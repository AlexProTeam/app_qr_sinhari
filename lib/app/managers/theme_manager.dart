import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: const ColorScheme.light(background: Colors.white),
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      colorScheme: const ColorScheme.dark(background: Colors.black),
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
    );
  }
}
