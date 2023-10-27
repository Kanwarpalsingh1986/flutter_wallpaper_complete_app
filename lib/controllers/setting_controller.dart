import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:music_streaming_mobile/model/setting.dart';

class SettingController extends GetxController {
  RxBool darkMode = false.obs;

  late SettingsModel settings;

  setCurrentMode() async {
    darkMode.value = await SharedPrefs().isDarkMode();
    update();
  }

  setDarkMode(bool value) {
    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );

    AppThemeSetting.setDisplayMode(
        value == true ? DisplayMode.dark : DisplayMode.light);
    SharedPrefs().setDarkMode(value);
    darkMode.value = value;
    update();
  }

  getSettings() {
    getIt<FirebaseManager>().getSettings().then((value) {
      settings = value!;
    });
  }
}
