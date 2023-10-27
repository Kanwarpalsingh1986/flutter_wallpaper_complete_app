import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

class WallpaperDetail extends StatefulWidget {
  final WallpaperModel wallpaper;

  const WallpaperDetail({Key? key, required this.wallpaper}) : super(key: key);

  @override
  State<WallpaperDetail> createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> {
  final WallpaperController wallpaperController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    wallpaperController.loadWallpaper(widget.wallpaper.id);
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: GetBuilder<WallpaperController>(
            init: wallpaperController,
            builder: (ctx) {
              return wallpaperController.isLoading == true
                  ? Container()
                  : Stack(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: WallpaperTile(
                              showCoins: false,
                              canNavigate: false,
                              wallpaper: widget.wallpaper,
                            )),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              height: 100,
                              child: Row(
                                children: [
                                  Expanded(child: creatorInfo()),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    color: Theme.of(context).backgroundColor,
                                    child: const ThemeIconWidget(
                                      ThemeIcon.download,
                                      size: 30,
                                    ),
                                  ).circular.ripple(() {
                                    downloadFile(widget.wallpaper.image);
                                  }),
                                ],
                              ).hP16,
                            )),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: Container(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.25),
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ThemeIconWidget(
                                      ThemeIcon.backArrow,
                                      size: 30,
                                      color: Theme.of(context).iconTheme.color,
                                    ).ripple(() {
                                      Get.back();
                                    }),
                                    Row(
                                      children: [
                                        ThemeIconWidget(
                                          widget.wallpaper.isLiked()
                                              ? ThemeIcon.favFilled
                                              : ThemeIcon.fav,
                                          color: widget.wallpaper.isLiked()
                                              ? Theme.of(context).errorColor
                                              : Theme.of(context)
                                                  .primaryColorDark,
                                          size: 25,
                                        ).p8.ripple(() {
                                          if (getIt<UserProfileManager>()
                                                  .user ==
                                              null) {
                                            Get.to(() => const AskForLogin());
                                          } else {
                                            wallpaperController
                                                .likeUnlikeWallpaper(
                                                    widget.wallpaper);
                                          }
                                        }),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          LocalizationString.report,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ).ripple(() {
                                          wallpaperController.reportWallpaper(
                                              wallpaperController
                                                  .wallpaper.value!);
                                          showMessage(
                                              LocalizationString
                                                  .wallpaperReported,
                                              false);
                                        }),
                                      ],
                                    ),
                                  ],
                                ).setPadding(top: 50, left: 16, right: 16)))
                      ],
                    );
            }));
  }

  Widget creatorInfo() {
    return wallpaperController.artist.value == null
        ? Container()
        : Row(
            children: [
              wallpaperController.artist.value!.image != null
                  ? Image.network(
                      wallpaperController.artist.value!.image!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ).circular
                  : Image.asset(
                      'assets/images/profile.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(wallpaperController.artist.value!.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      wallpaperController.artist.value!.wallpapersCount > 0
                          ? Text('${wallpaperController.artist.value!.wallpapersCount} ${LocalizationString.wallpapers},',
                                  style: Theme.of(context).textTheme.bodyLarge)
                              .rP8
                          : Container(),
                      wallpaperController.artist.value!.totalDownloads > 0
                          ? Text('${wallpaperController.artist.value!.totalDownloads} ${LocalizationString.downloads.toLowerCase()}',
                                  style: Theme.of(context).textTheme.bodyLarge)
                              .rP8
                          : Container(),
                    ],
                  ),
                ],
              )
            ],
          ).ripple(() {
            Get.to(
                () => ArtistDetail(id: wallpaperController.artist.value!.id));
          });
  }

  void downloadFile(String url) async {
    if (getIt<UserProfileManager>().user == null) {
      Get.to(() => const AskForLogin());
    } else {
      if (getIt<UserProfileManager>()
              .user!
              .downloadedWallpapers
              .contains(widget.wallpaper.id) ==
          true) {
        saveWallpaper(url);
      } else if (widget.wallpaper.coinsToUnlock != 0) {
        if (getIt<UserProfileManager>().user!.coins >=
            widget.wallpaper.coinsToUnlock) {
          showDialog(
              context: context,
              builder: (ctx) {
                return Center(
                  child: unlockWallpaperConfirmationPopup(
                      context: context,
                      coins: widget.wallpaper.coinsToUnlock,
                      yesCallback: () {
                        saveWallpaper(url);
                      }),
                );
              });
        }
      } else {
        saveWallpaper(url);
      }
    }
  }

  saveWallpaper(String url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        showMessage(LocalizationString.wallpaperNotSaved, true);
        return;
      }

      if (Platform.isAndroid) {
        var path = await ImageDownloader.findPath(imageId);
        showActionSheet(path!);
      }

      showMessage(LocalizationString.wallpaperSaved, false);
      getIt<FirebaseManager>().increaseWallpaperDownloadCount(widget.wallpaper);
      if (widget.wallpaper.coinsToUnlock > 0) {
        getIt<FirebaseManager>().updateCoins(-widget.wallpaper.coinsToUnlock);
      }
    } on PlatformException catch (error) {
      showMessage(error.code, true);
    }
  }

  showActionSheet(String path) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.pop(context);
              int location =
                  WallpaperManager.HOME_SCREEN; //can be Home/Lock Screen
              bool result =
                  await WallpaperManager.setWallpaperFromFile(path, location);
              if (result == true) {
                showMessage(LocalizationString.setAsHomeScreenDone, false);
              } else {
                showMessage(LocalizationString.errorMessage, false);
              }
            },
            child: Text(LocalizationString.setAsHomeScreen),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              int location =
                  WallpaperManager.LOCK_SCREEN; //can be Home/Lock Screen
              bool result =
                  await WallpaperManager.setWallpaperFromFile(path, location);
              if (result == true) {
                showMessage(LocalizationString.setAsLockScreen, false);
              } else {
                showMessage(LocalizationString.errorMessage, false);
              }
            },
            child: Text(LocalizationString.setAsLockScreen),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () async {
              Navigator.pop(context);
              int location =
                  WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
              bool result =
                  await WallpaperManager.setWallpaperFromFile(path, location);
              if (result == true) {
                showMessage(LocalizationString.setAsBothScreen, false);
              } else {
                showMessage(LocalizationString.errorMessage, false);
              }
            },
            child: Text(LocalizationString.setAsBothScreen),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              LocalizationString.cancel,
            ),
          )
        ],
      ),
    );
  }

  showMessage(String message, bool isError) {
    AppUtil.showToast(message: message, isSuccess: !isError);
  }
}
