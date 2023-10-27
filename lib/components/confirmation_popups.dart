import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

Widget unlockWallpaperConfirmationPopup(
    {required BuildContext context,
    required int coins,
    required VoidCallback yesCallback}) {
  return Container(
    height: 350,
    width: MediaQuery.of(context).size.width * 0.8,
    color: Theme.of(context).backgroundColor,
    child: Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/coins.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Are you sure? you want to spend $coins coins to unlock this wallpaper',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                width: 120,
                child: BorderButtonType1(
                    text: LocalizationString.cancel.toUpperCase(),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    onPress: () {
                      Get.back();
                    }),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 45,
                width: 120,
                child: FilledButtonType1(
                    text: LocalizationString.ok.toUpperCase(),
                    enabledTextStyle: Theme.of(context).textTheme.titleLarge,
                    onPress: () {
                      Get.back();

                      yesCallback();
                    }),
              )
            ],
          )
        ],
      ).p25,
    ),
  ).round(20);
}
