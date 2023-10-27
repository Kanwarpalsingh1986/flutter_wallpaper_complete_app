import 'package:get/get.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class AppSearchController extends GetxController {
  Rx<int> selectedTab = 0.obs;
  RxList<WallpaperModel> wallpapers = <WallpaperModel>[].obs;
  bool isLoading = false;

  changeTab(int index) {
    selectedTab = Rx(index);
    update();
  }

  loadData(
      {String? searchText,
        String? categoryId,
        String? colorCode,
        DataType? dataType,
        String? artistId}) {
    isLoading = true;
    getIt<FirebaseManager>()
        .searchWallpapers(
        searchText: searchText,
        categoryId: categoryId,
        colorCode: colorCode,
        artistId: artistId)
        .then((result) {
      wallpapers = RxList(result);
      isLoading = false;
      update();
    });
  }

  likeUnlikeWallpaper(WallpaperModel wallpaper) {
    isLoading = true;
    if (wallpaper.isLiked() == true) {
      getIt<FirebaseManager>().unlikeWallpaper(wallpaper.id);
    } else {
      getIt<FirebaseManager>().likeWallpaper(wallpaper.id);
    }
    isLoading = false;
    update();
  }
}