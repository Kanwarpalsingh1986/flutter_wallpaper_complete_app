import 'package:flutter/material.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await setupServiceLocator();
  await Firebase.initializeApp();
  await getIt<UserProfileManager>().refreshProfile();

  bool isDarkTheme = await SharedPrefs().isDarkMode();

  Get.changeThemeMode(isDarkTheme ? ThemeMode.dark : ThemeMode.light);

  Get.put(ArtistController());
  Get.put(CategoryController());
  Get.put(DashboardController());
  Get.put(LoginController());
  Get.put(MainScreenController());
  Get.put(AppSearchController());
  Get.put(UserController());
  Get.put(WallpaperController());
  Get.put(BuyCoinsController());
  Get.put(SettingController());

  final SettingController settingController = Get.find();
  settingController.getSettings();

  runApp(
    EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'AE'),
          Locale('ar', 'SA'),
          Locale('ar', 'DZ'),
          Locale('de', 'DE'),
          Locale('fr', 'FR'),
          Locale('ru', 'RU')
        ],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: const MainApp()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: EasyLoading.init(),
      home: const MainScreen(),
    );
  }
}
