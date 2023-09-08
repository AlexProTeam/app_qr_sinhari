import 'package:flutter/material.dart';

import '../di/injection.dart';
import '../managers/shared_pref_manager.dart';
import '../managers/theme_manager.dart';

class SessionUtils {
  static bool get isDarkTheme =>
      getIt<ThemeManager>().currentTheme == ThemeMode.dark;

  static void saveAccessToken(String accessToken) =>
      getIt<SharedPreferencesManager>().putString(
        SharedPreferenceKey.keyAccessToken,
        accessToken,
      );
}
