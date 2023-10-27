import 'package:get/get.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class WallpaperController extends GetxController {
  RxList<WallpaperModel> wallpapers = <WallpaperModel>[].obs;
  RxList<WallpaperModel> likedWallpapers = <WallpaperModel>[].obs;
  RxList<WallpaperModel> downloadedWallpapers = <WallpaperModel>[].obs;
  RxList<ColorCodeModel> colors = <ColorCodeModel>[].obs;

  Rx<ArtistModel?> artist = (null).obs;
  Rx<WallpaperModel?> wallpaper = (null).obs;
  WallpaperQueryType queryType = WallpaperQueryType.latest;
  List<String> filtersList = [
    "New",
    "Popular",
    "Most searched",
    "Trending",
  ];

  RxString selectedFilter = "New".obs;
  Rx<ColorCodeModel?> selectedColor = Rx<ColorCodeModel?>(null);

  bool isLoading = false;
  DataType? dataType;
  CategoryModel? category;

  clear() {
    wallpapers.clear();
    artist.value = null;
    wallpaper.value = null;
  }

  setPref({DataType? dataType, CategoryModel? category}) {
    this.dataType = dataType;
    this.category = category;
  }

  selectColor(ColorCodeModel? color) {
    if (selectedColor.value != null) {
      selectedColor.value = null;
    } else {
      selectedColor.value = color;
    }
    update();
    loadData();
  }

  loadData() async {
    if (dataType != null) {
      if (dataType == DataType.likedWallpapers) {
        loadLikedWallpapers(getIt<UserProfileManager>().user!.likedWallpapers,
            selectedColor.value?.code);
      } else {
        loadDownloadedWallpapers(
            getIt<UserProfileManager>().user!.downloadedWallpapers,
            selectedColor.value?.code);
      }
    } else {
      loadWallpapers(
          categoryId: category!.id, colorCode: selectedColor.value?.code);
    }
  }

  loadWallpapers(
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

  loadColors() {
    isLoading = true;
    getIt<FirebaseManager>().getAllColors().then((result) {
      colors = RxList(result);
      isLoading = false;
    });
  }

  loadWallpaper(String id) {
    isLoading = true;
    getIt<FirebaseManager>().getWallpaper(id).then((result) {
      wallpaper = Rx(result!);
      getArtistDetail(wallpaper.value!.addedByUserId);
      update();
    });
  }

  getArtistDetail(String id) {
    getIt<FirebaseManager>().getArtist(id).then((result) {
      artist = Rx(result!);
      isLoading = false;
      update();
    });
  }

  loadLikedWallpapers(List<String> ids, String? color) async {
    isLoading = true;
    getIt<FirebaseManager>()
        .getMultipleWallpapersByIds(ids: ids, colorCode: color)
        .then((result) {
      likedWallpapers = RxList(result);
      isLoading = false;
      update();
    });
  }

  loadDownloadedWallpapers(List<String> ids, String? color) async {
    isLoading = true;
    getIt<FirebaseManager>()
        .getMultipleWallpapersByIds(ids: ids, colorCode: color)
        .then((result) {
      downloadedWallpapers = RxList(result);
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

  reportWallpaper(WallpaperModel wallpaper) {
    getIt<FirebaseManager>()
        .reportAbuse(wallpaper.id, wallpaper.name, DataType.wallpapers);
  }

  selectSegment(int index) {
    switch (index) {
      case 0:
        queryType = WallpaperQueryType.latest;
        break;
      case 1:
        queryType = WallpaperQueryType.popular;
        break;
      case 2:
        queryType = WallpaperQueryType.mostSearched;
        break;
      case 3:
        queryType = WallpaperQueryType.trending;
        break;
    }
    selectedFilter.value = filtersList[index];
    update();
    loadDashboardData();
  }

  loadDashboardData() {
    getIt<FirebaseManager>()
        .searchWallpapers(queryType: queryType)
        .then((result) {
      wallpapers.value = result;
      update();
    });
  }

}
