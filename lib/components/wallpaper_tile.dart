import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

class WallpaperTile extends StatelessWidget {
  final WallpaperModel wallpaper;
  final VoidCallback? likeUnlikeCallback;
  final bool? canNavigate;
  final bool showCoins;

  const WallpaperTile(
      {Key? key,
      required this.wallpaper,
      this.likeUnlikeCallback,
      this.canNavigate,
        required this.showCoins})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.65,
      child: Stack(
        children: [
          Image.network(
            wallpaper.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ).round(20).ripple(() {
            if (canNavigate != false) {
              Get.to(() => WallpaperDetail(wallpaper: wallpaper));
            }
          }),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 wallpaper.coinsToUnlock != 0 && showCoins == true
                    ? Container(
                        color: Theme.of(context).backgroundColor,
                        child: Row(
                          children: [
                            ThemeIconWidget(
                              ThemeIcon.coins,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              wallpaper.coinsToUnlock.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ).setPadding(left: 10, right: 10, top: 5, bottom: 5),
                      ).shadow(context: context).round(10) : Container(),
                likeUnlikeCallback == null
                    ? Container()
                    : Container(
                        color: Theme.of(context).backgroundColor,
                        child: ThemeIconWidget(
                          wallpaper.isLiked()
                              ? ThemeIcon.favFilled
                              : ThemeIcon.fav,
                          color: wallpaper.isLiked()
                              ? Theme.of(context).errorColor
                              : Theme.of(context).primaryColorLight,
                          size: 25,
                        ).p8.ripple(() {
                          likeUnlikeCallback!();
                        }),
                      ).shadow(context: context).circular,
              ],
            ).p8,
          )
        ],
      ),
    );
  }
}
