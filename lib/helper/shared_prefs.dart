import 'package:music_streaming_mobile/helper/common_import.dart';

class SharedPrefs {
  //Set/Get UserLoggedIn Status
  void setUserLoggedIn(bool loggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', loggedIn);
    AppConfig.isLoggedIn = loggedIn;
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  //Set/Get UserLoggedIn Status
  void setAuthorizationKey(String authKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authKey', authKey);
    prefs.setBool('isLoggedIn', true);
    AppConfig.isLoggedIn = true;
  }

  Future<String> getAuthorizationKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('authKey') as String;
  }

  void clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }


  setDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Future<bool> isDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('darkMode') as bool? ?? false;
  }

  setProMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPro', value);
  }

  Future<bool> isProMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('isPro') as bool? ?? false;
  }
}
