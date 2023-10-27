import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_streaming_mobile/model/setting.dart';
import 'package:music_streaming_mobile/model/transaction_model.dart';

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  String randomString = base64UrlEncode(values);
  return randomString.replaceAll('=', '');
}

class FirebaseResponse {
  bool? status;
  String? message;
  Object? result;
  UserCredential? credential;

  FirebaseResponse(this.status, this.message);
}

class FirebaseManager {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseResponse? response;
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  CollectionReference artistCollection =
      FirebaseFirestore.instance.collection('artists');

  CollectionReference wallpapersCollection =
      FirebaseFirestore.instance.collection('wallpapers');

  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference colorsCollection =
      FirebaseFirestore.instance.collection('colors');

  CollectionReference banners =
      FirebaseFirestore.instance.collection('banners');

  CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');

  CollectionReference reports =
      FirebaseFirestore.instance.collection('reports');
  CollectionReference contact =
      FirebaseFirestore.instance.collection('contact');

  CollectionReference counter =
      FirebaseFirestore.instance.collection('counter');

  CollectionReference settings =
      FirebaseFirestore.instance.collection('settings');

  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<FirebaseResponse> insertUser(
      {required String id, String? name, String? phone, String? email}) async {
    final batch = FirebaseFirestore.instance.batch();
    DocumentReference doc = userCollection.doc(id);
    DocumentReference counterDoc = counter.doc('counter');

    batch.set(doc,
        {'id': id, 'name': name, 'phone': phone, 'status': 1, 'email': email});
    batch.update(counterDoc, {'readers': FieldValue.increment(1)});

    await batch.commit().then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<FirebaseResponse> updateUser({String? name, String? bio}) async {
    DocumentReference doc =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    await doc.update({'name': name, 'bio': bio}).then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<FirebaseResponse> updateCoins(int coins) async {
    DocumentReference doc =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    await doc.update({'coins': FieldValue.increment(coins)}).then((value) {
      response = FirebaseResponse(true, null);
      getIt<UserProfileManager>().refreshProfile();
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<FirebaseResponse> saveTransaction(
      TransactionModel transaction) async {
    DocumentReference transactionDoc = transactions.doc(transaction.id);
    DocumentReference counterDoc = counter.doc('counter');
    DocumentReference userDoc =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    WriteBatch batch = FirebaseFirestore.instance.batch();

    var json = transaction.toJson();
    json['createdAt'] = FieldValue.serverTimestamp();

    batch.set(transactionDoc, json);
    batch.update(counterDoc, {'purchases': FieldValue.increment(1)});
    batch.update(userDoc, {'coins': FieldValue.increment(transaction.coins)});

    await batch.commit().then((value) {
      response = FirebaseResponse(true, null);
      getIt<UserProfileManager>().refreshProfile();
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<String> updateProfileImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef =
        storageRef.child("${FirebaseAuth.instance.currentUser!.uid}.jpg");

    await imageRef.putFile(imageFile);
    String path = await imageRef.getDownloadURL();

    DocumentReference userDoc =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    getIt<UserProfileManager>().user!.image = path;
    await userDoc.update({
      'image': path,
    }).then((value) {
      // response = FirebaseResponse(true, null);
    }).catchError((error) {
      // response = FirebaseResponse(false, error);
    });
    return path;
  }

  loginAnonymously(VoidCallback callback) async {
    EasyLoading.show(status: LocalizationString.loading);
    await auth.signInAnonymously().then((value) => callback());
    EasyLoading.dismiss();
  }

  Future<FirebaseResponse> signUpViaEmail(
      {required String email,
      required String password,
      required String name}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        await insertUser(id: user.uid, name: name, email: email);
        response = FirebaseResponse(true, null);
      }
    } catch (error) {
      response = FirebaseResponse(false, error.toString());
    }

    return response!;
  }

  Future<FirebaseResponse> loginViaEmail({
    required String email,
    required String password,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        response = FirebaseResponse(true, null);
      }
      response!.credential = userCredential;
    } catch (error) {
      response =
          FirebaseResponse(false, LocalizationString.userNameOrPasswordIsWrong);
      response!.credential = null;
    }

    return response!;
  }

  loginViaPhone(
      {required String phoneNumber,
      required Function(String) verificationIdHandler,
      required Function(String) verificationFailedHandler}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // if (e.code == 'invalid-phone-number') {}
        verificationFailedHandler('Invalid phone number');
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdHandler(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOTP(String smsCode, String verificationID,
      Function(bool, bool) callback) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    UserCredential userCredential = await auth.signInWithCredential(credential);

    if (userCredential.user != null) {
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await insertUser(
            id: userCredential.user!.uid,
            name: '',
            email: '',
            phone: userCredential.user!.phoneNumber!);

        callback(true, true);
      } else {
        callback(true, false);
      }
      getIt<UserProfileManager>().refreshProfile();
    } else {
      callback(false, false);
    }
  }

  Future<UserModel?> getUser(String id) async {
    UserModel? user;
    await userCollection.doc(id).get().then((doc) {
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return user;
  }

  Future<FirebaseResponse> changeProfilePassword({required String pwd}) async {
    await FirebaseAuth.instance.currentUser?.updatePassword(pwd).then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<FirebaseResponse> resetPassword(String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<List<ArtistModel>> searchArtists({
    String? searchText,
  }) async {
    List<ArtistModel> list = [];

    Query query = artistCollection;

    if (searchText != null) {
      query = query.where("keywords", arrayContainsAny: [searchText]);
    }

    await query.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        list.add(ArtistModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return list;
  }

  Future<ArtistModel?> getArtist(String id) async {
    ArtistModel? artist;
    await artistCollection.doc(id).get().then((doc) {
      artist = ArtistModel.fromJson(doc.data() as Map<String, dynamic>);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return artist;
  }

  Future<FirebaseResponse> likeWallpaper(String id) async {
    getIt<UserProfileManager>().user!.likedWallpapers.add(id);

    final batch = FirebaseFirestore.instance.batch();
    DocumentReference currentUserDoc =
        userCollection.doc(auth.currentUser!.uid); //.collection('following');
    DocumentReference itemDoc = wallpapersCollection.doc(id);

    batch.update(currentUserDoc, {
      'likedWallpapers': FieldValue.arrayUnion([id]),
    });
    batch.update(itemDoc, {'likesCount': FieldValue.increment(1)});

    await batch.commit().then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return response!;
  }

  Future<FirebaseResponse> unlikeWallpaper(String id) async {
    getIt<UserProfileManager>().user!.likedWallpapers.remove(id);
    final batch = FirebaseFirestore.instance.batch();
    DocumentReference currentUserDoc =
        userCollection.doc(auth.currentUser!.uid); //.collection('following');
    DocumentReference itemDoc = wallpapersCollection.doc(id);

    batch.update(currentUserDoc, {
      'likedWallpapers': FieldValue.arrayRemove([id]),
    });
    batch.update(itemDoc, {'likesCount': FieldValue.increment(-1)});

    await batch.commit().then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return response!;
  }

  Future<FirebaseResponse> increaseWallpaperSearchCount(
      WallpaperModel wallpaper) async {
    DocumentReference doc = wallpapersCollection.doc(wallpaper.id);

    await doc.update({'searchedCount': FieldValue.increment(1)}).then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<FirebaseResponse> increaseWallpaperDownloadCount(
      WallpaperModel wallpaper) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    DocumentReference doc = wallpapersCollection.doc(wallpaper.id);
    DocumentReference userDoc =
        userCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    batch.update(doc, {'totalDownloads': FieldValue.increment(1)});
    batch.update(userDoc, {
      'downloadedWallpapers': FieldValue.arrayUnion([wallpaper.id])
    });

    await batch.commit().then((value) {
      response = FirebaseResponse(true, null);
      getIt<UserProfileManager>().refreshProfile();
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<List<WallpaperModel>> getTrendingWallpapers(
      {String? categoryId}) async {
    List<WallpaperModel> wallpapers = [];

    Query query = wallpapersCollection
        .orderBy('totalDownloads', descending: true)
        .orderBy('createdAt');

    if (categoryId != null) {
      query = query.where("categoryId", isEqualTo: categoryId);
    }

    await query.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        wallpapers
            .add(WallpaperModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return wallpapers;
  }

  Future<List<BannerModel>> getAllBanners() async {
    List<BannerModel> bannersList = [];

    await banners.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        bannersList
            .add(BannerModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return bannersList;
  }

  Future<List<WallpaperModel>> getTopWallpapers({String? categoryId}) async {
    List<WallpaperModel> list = [];

    Query query =
        wallpapersCollection.orderBy('totalDownloads', descending: true);

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    await query.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        list.add(WallpaperModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return list;
  }

  Future<List<WallpaperModel>> searchWallpapers(
      {String? searchText,
      String? categoryId,
      String? artistId,
      String? colorCode,
      WallpaperQueryType? queryType}) async {
    List<WallpaperModel> wallpapersList = [];

    Query query = wallpapersCollection;

    if (searchText != null) {
      query = query.where("keywords", arrayContainsAny: [searchText]);
    }

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    if (colorCode != null) {
      query = query.where('colorCode', isEqualTo: colorCode);
    }

    if (artistId != null) {
      query = query.where('addedByUserId', isEqualTo: artistId);
    }

    if (queryType != null) {
      if (queryType == WallpaperQueryType.popular) {
        query = query.orderBy('totalDownloads', descending: true);
      } else if (queryType == WallpaperQueryType.trending) {
        query = query
            .orderBy('searchedCount', descending: true)
            .orderBy('createdAt', descending: true);
      } else if (queryType == WallpaperQueryType.mostSearched) {
        query = query.orderBy('searchedCount', descending: true);
      } else if (queryType == WallpaperQueryType.latest) {
        query = query.orderBy('createdAt', descending: true);
      }
    }

    await query.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        wallpapersList
            .add(WallpaperModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return wallpapersList;
  }

  Future<WallpaperModel?> getWallpaper(String id) async {
    WallpaperModel? wallpaper;
    await wallpapersCollection.doc(id).get().then((doc) {
      wallpaper = WallpaperModel.fromJson(doc.data() as Map<String, dynamic>);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return wallpaper;
  }

  Future<FirebaseResponse> reportAbuse(
      String id, String name, DataType type) async {
    String reportId = '${id}_${auth.currentUser!.uid}';

    WriteBatch batch = FirebaseFirestore.instance.batch();

    DocumentReference doc = reports.doc(reportId);
    DocumentReference wallpaperDoc = wallpapersCollection.doc(id);

    var reportData = {'id': id, 'name': name, 'type': 1};

    batch.set(doc, reportData);
    batch.update(wallpaperDoc, {'reportCount': FieldValue.increment(1)});

    await batch.commit().then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<FirebaseResponse> sendContactusMessage(
      String name, String email, String phone, String message) async {
    String id = getRandString(15);
    DocumentReference doc = contact.doc(id);
    await doc.set({
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
      'status': 1
    }).then((value) {
      response = FirebaseResponse(true, null);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });
    return response!;
  }

  Future<List<CategoryModel>> searchCategories({String? searchText}) async {
    List<CategoryModel> categoriesList = [];

    Query query = categoriesCollection;

    if (searchText != null) {
      query = query.where("keywords", arrayContainsAny: [searchText]);
    }

    await query.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        categoriesList
            .add(CategoryModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return categoriesList;
  }

  Future<List<Section>> getHomePageData({String? categoryId}) async {
    List<Section> sections = [];

    await getIt<UserProfileManager>().refreshProfile();

    var responses = await Future.wait([
      getTrendingWallpapers(categoryId: categoryId),
    ]);

    if (responses[0].isNotEmpty) {
      sections.add(Section(
          heading: 'Trending wallpapers',
          items: responses[0],
          dataType: DataType.wallpapers));
    }

    return sections;
  }

  Future<List<WallpaperModel>> getMultipleWallpapersByIds(
      {required List<String> ids, String? colorCode}) async {
    List<String> copiedId = List.from(ids);

    List<WallpaperModel> list = [];

    while (copiedId.isNotEmpty) {
      List<String> firstTenIds = [];

      if (copiedId.length > 10) {
        firstTenIds = copiedId.sublist(0, 10);
      } else {
        firstTenIds = copiedId.sublist(0, copiedId.length);
      }

      Query query = wallpapersCollection.where("id", whereIn: firstTenIds);

      if (colorCode != null) {
        query = query.where('colorCode', isEqualTo: colorCode);
      }

      await query.get().then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          list.add(WallpaperModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }).catchError((error) {
        response = FirebaseResponse(false, error);
      });

      if (copiedId.length > 10) {
        copiedId.removeRange(0, 10);
      } else {
        copiedId.clear();
      }
    }

    return list;
  }

  Future<List<ColorCodeModel>> getAllColors() async {
    List<ColorCodeModel> colorsList = [];

    await colorsCollection.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        colorsList
            .add(ColorCodeModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return colorsList;
  }

  Future<List<PackageModel>> getAllPackages() async {
    List<PackageModel> list = [];

    await packages.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        list.add(PackageModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return list;
  }

  Future<SettingsModel?> getSettings() async {
    SettingsModel? settingsModel;
    await settings.doc('settings').get().then((doc) {
      settingsModel =
          SettingsModel.fromJson(doc.data() as Map<String, dynamic>);
    }).catchError((error) {
      response = FirebaseResponse(false, error);
    });

    return settingsModel;
  }
}
