import 'package:get/get.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class ArtistController extends GetxController{
  Rx<ArtistModel?> artist = (null)
      .obs;

  Rx<int> selectedTab = 0.obs;
  bool isLoading = false;

  changeTab(int index) {
    selectedTab = Rx(index);
    update();
  }

  getArtistDetail({required String id}) {
    isLoading = true;
    getIt<FirebaseManager>().getArtist(id).then((result) {
      artist = Rx(result!);
      isLoading = false;
      update();
    });
  }
}
