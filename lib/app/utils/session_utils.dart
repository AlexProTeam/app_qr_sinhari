// Project imports:
part of app_layer;

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

  static bool get havedLogin =>
      pref.getBool(
        SharedPreferenceKey.havedLogin,
      ) ??
      false;

  static void saveHavedLogin(bool data) =>
      getIt<SharedPreferencesManager>().putBool(
        SharedPreferenceKey.havedLogin,
        data,
      );

  static Future<void> get deleteHavedLogin => pref.removeByKey(
        SharedPreferenceKey.havedLogin,
      );

  static String get deviceId =>
      pref.getString(
        SharedPreferenceKey.deviceId,
      ) ??
      '';

  static void saveDeviceId(String accessToken) =>
      getIt<SharedPreferencesManager>().putString(
        SharedPreferenceKey.deviceId,
        accessToken,
      );

  static Future<void> get deleteDeviceId => pref.removeByKey(
        SharedPreferenceKey.deviceId,
      );

  /// đếm số lượng trong đơn hàng
  static int qtyCartsByIds(num id) {
    if (qtyCartsList.isEmpty) {
      return 0;
    }

    return qtyCartsList
        .where((element) => element == id.toString())
        .toList()
        .length;
  }

  static int get qtyCarts => qtyCartsList.toSet().length;

  static List<String> get qtyCartsList => pref
      .getStringList(
        SharedPreferenceKey.qtyCarts,
      )
      .toList();

  static Future<void> saveQtyCarts(List<String> data) =>
      getIt<SharedPreferencesManager>().putStringList(
        SharedPreferenceKey.qtyCarts,
        data,
      );

  static Future<void> get deleteQtyCarts => pref.removeByKey(
        SharedPreferenceKey.qtyCarts,
      );

  static Future<void> get clearLogout async {
    deleteAccessToken;
    deleteHavedLogin;
    deleteQtyCarts;
  }
}
