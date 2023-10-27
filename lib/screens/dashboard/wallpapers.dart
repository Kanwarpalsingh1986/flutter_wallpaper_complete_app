import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

class Wallpapers extends StatefulWidget {
  final CategoryModel? category;
  final DataType? dataType;

  const Wallpapers({Key? key, this.category, this.dataType}) : super(key: key);

  @override
  State<Wallpapers> createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  final WallpaperController wallpaperController = Get.find();

  UserModel? user;
  String title = '';

  @override
  void initState() {
    // TODO: implement initState
    user = getIt<UserProfileManager>().user;

    wallpaperController.setPref(
        dataType: widget.dataType, category: widget.category);
    wallpaperController.loadColors();
    wallpaperController.loadData();

    if (widget.dataType != null) {
      if (widget.dataType == DataType.likedWallpapers) {
        title = LocalizationString.likedWallpapers;
      } else {
        title = LocalizationString.downloadedWallpapers;
      }
    } else {
      title = widget.category!.name;
    }
    InterstitialAds().loadInterstitialAd();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    wallpaperController.clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(Wallpapers oldWidget) {
    super.didUpdateWidget(oldWidget);
    wallpaperController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          BackNavBar(
            title: title,
            backTapHandler: () {
              Get.back();
            },
          ),
          GetBuilder<WallpaperController>(
              init: wallpaperController,
              builder: (ctx) {
                return SizedBox(
                    height: 40,
                    child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Container(
                            height: wallpaperController.selectedColor.value ==
                                    wallpaperController.colors[index]
                                ? 38
                                : 40,
                            width: wallpaperController.selectedColor.value ==
                                    wallpaperController.colors[index]
                                ? 38
                                : 40,
                            color: wallpaperController.colors[index].code
                                .toColor(),
                          )
                              .circular
                              .borderWithRadius(
                                  context: context,
                                  value:
                                      wallpaperController.selectedColor.value ==
                                              wallpaperController.colors[index]
                                          ? 2
                                          : 0,
                                  radius: 20)
                              .ripple(() {
                            wallpaperController
                                .selectColor(wallpaperController.colors[index]);
                          });
                        },
                        separatorBuilder: (ctx, index) {
                          return const SizedBox(width: 20);
                        },
                        itemCount: wallpaperController.colors.length));
              }).vP16,
          Expanded(child: wallpapersView().hP16),
        ],
      ),
    );
  }

  Widget wallpapersView() {
    return GetBuilder<WallpaperController>(
        init: wallpaperController,
        builder: (context) {
          List<WallpaperModel> wallpapers = [];
          if (widget.dataType != null) {
            if (widget.dataType == DataType.likedWallpapers) {
              wallpapers = wallpaperController.likedWallpapers;
            } else {
              wallpapers = wallpaperController.downloadedWallpapers;
            }
          } else {
            wallpapers = wallpaperController.wallpapers;
          }

          return GridView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: wallpapers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (BuildContext context, int index) {
              return WallpaperTile(
                wallpaper: wallpapers[index],
                showCoins: true,
                likeUnlikeCallback: () {
                  if (getIt<UserProfileManager>().user == null) {
                    Get.to(() => const AskForLogin());
                  } else {
                    wallpaperController.likeUnlikeWallpaper(wallpapers[index]);
                  }
                },
              );
            },
          );
        });
  }
}
