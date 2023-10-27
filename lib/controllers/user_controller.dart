import 'package:get/get.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:image_picker/image_picker.dart' as image_picker;

class UserController extends GetxController {
  final image_picker.ImagePicker _picker = image_picker.ImagePicker();

  Rx<int> selectedTab = 0.obs;
  RxList<ArtistModel> artists = <ArtistModel>[].obs;
  RxString imagePath = ''.obs;

  changeTab(int index) {
    selectedTab = Rx(index);
    update();
  }

  setProfileImagePath() {
    if (getIt<UserProfileManager>().user!.image != null) {
      imagePath.value = getIt<UserProfileManager>().user!.image!;
      update();
    }
  }

  updateUser({String? name, String? bio}) {
    EasyLoading.show(status: LocalizationString.loading);
    getIt<UserProfileManager>().user!.name = name;
    getIt<UserProfileManager>().user!.bio = bio;

    getIt<FirebaseManager>().updateUser(name: name, bio: bio).then((value) {
      EasyLoading.dismiss();
      Get.back();
    });
  }

  uploadProfileImage() async {
    final image_picker.XFile? image =
    await _picker.pickImage(source: image_picker.ImageSource.gallery);

    if (image != null) {
      getIt<FirebaseManager>()
          .updateProfileImage(File(image.path))
          .then((value) {
        imagePath.value = value;
        update();
      });
    }
  }

  searchUsers({String? searchText}){
      getIt<FirebaseManager>().searchArtists(searchText: searchText).then((result) {
        artists.value = result;
        update();
      });
  }
}
