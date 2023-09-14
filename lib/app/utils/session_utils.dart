import 'package:flutter/material.dart';

import '../di/injection.dart';
import '../managers/shared_pref_manager.dart';
import '../managers/theme_manager.dart';

class SessionUtils {
  static bool get isDarkTheme =>
      getIt<ThemeManager>().currentTheme == ThemeMode.dark;

  static SharedPreferencesManager get pref => getIt<SharedPreferencesManager>();

  static String get accessToken =>
      pref.getString(
        SharedPreferenceKey.keyAccessToken,
      ) ??
      '';

  static void saveAccessToken(String accessToken) =>
      getIt<SharedPreferencesManager>().putString(
        SharedPreferenceKey.keyAccessToken,
        accessToken,
      );

  static Future<void> get deleteAccessToken => pref.removeByKey(
        SharedPreferenceKey.keyAccessToken,
      );

  static Future<void> get clearLogout async {
    deleteAccessToken;
  }
}
