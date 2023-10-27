import 'package:music_streaming_mobile/helper/common_import.dart';

class UserModel {
  String id;
  String? name;
  String? phone;
  String? bio;
  String? image;

  List<String> followingArtists;
  List<String> likedWallpapers;
  List<String> downloadedWallpapers;

  int status;
  int coins;

  UserModel({
    required this.id,
    this.image,
    this.name,
    this.phone,
    this.bio,
    required this.followingArtists,
    required this.likedWallpapers,
    required this.downloadedWallpapers,
    required this.status,
    required this.coins,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
        bio: json["bio"] ?? '',
        followingArtists: json["followingArtists"] == null
            ? []
            : (json["followingArtists"] as List<dynamic>)
                .map((e) => e.toString())
                .toList(),
        likedWallpapers: json["likedWallpapers"] == null
            ? []
            : (json["likedWallpapers"] as List<dynamic>)
                .map((e) => e.toString())
                .toList(),
        downloadedWallpapers: json["downloadedWallpapers"] == null
            ? []
            : (json["downloadedWallpapers"] as List<dynamic>)
                .map((e) => e.toString())
                .toList(),
        status: json["status"],
        coins: json["coins"] ?? 0,
      );

  String get infoToShow {
    if ((getIt<UserProfileManager>().user!.name ?? '').isNotEmpty) {
      return getIt<UserProfileManager>().user!.name!;
    }
    if ((getIt<UserProfileManager>().user!.phone ?? '').isNotEmpty) {
      return getIt<UserProfileManager>().user!.phone!;
    }

    return '';
  }

  String get getInitials {
    if ((getIt<UserProfileManager>().user!.name ?? '').isNotEmpty) {
      List<String> nameParts =
          getIt<UserProfileManager>().user!.name!.split(' ');
      if (nameParts.length > 1) {
        return nameParts[0].substring(0, 1).toUpperCase() +
            nameParts[1].substring(0, 1).toUpperCase();
      } else {
        return nameParts[0].substring(0, 1).toUpperCase();
      }
    }
    if ((getIt<UserProfileManager>().user!.phone ?? '').isNotEmpty) {
      return getIt<UserProfileManager>().user!.phone!.substring(0, 1);
    }
    List<String> nameParts = AppConfig.projectName.split(' ');
    if (nameParts.length > 1) {
      return nameParts[0].substring(0, 1).toUpperCase() +
          nameParts[1].substring(0, 1).toUpperCase();
    } else {
      return nameParts[0].substring(0, 1).toUpperCase();
    }
  }
}
