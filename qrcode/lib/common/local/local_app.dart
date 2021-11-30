import 'package:shared_preferences/shared_preferences.dart';

class LocalApp {
  final SharedPreferences sharedPreferences;

  LocalApp(this.sharedPreferences);

  Future saveStringSharePreference(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String? getStringSharePreference(String key) {
    return sharedPreferences.getString(key);
  }

  Future saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }
}
