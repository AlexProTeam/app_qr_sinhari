import 'package:flutter/material.dart';

const defaultAppBarHeight = 48.0;

class GScreenUtil {
  static late GScreenUtil _instance;
  static const int defaultWidth = 414;
  static const int defaultHeight = 896;

  /// Size of the screen phone in UI Design , px
  num? uiWidthPx;
  num? uiHeightPx;

  /// allowFontScaling Specifies whether fonts should scale
  /// to respect Text Size accessibility settings. The default is false.
  bool? allowFontScaling;

  static late MediaQueryData? _mediaQueryData;
  static double? _screenWidthDp = 0;
  static double? _screenHeightDp = 0;
  static double? _pixelRatio = 0;
  static double? _statusBarHeight = 0;
  static double? _bottomBarHeight = 0;
  static double? _textScaleFactor = 0;

  factory GScreenUtil() {
    return _instance;
  }

  GScreenUtil._();

  static void init(BuildContext context,
      {num width = defaultWidth,
      num height = defaultHeight,
      bool allowFontScaling = false}) {
    _instance = GScreenUtil._();
    _instance.uiWidthPx = width;
    _instance.uiHeightPx = height;
    _instance.allowFontScaling = allowFontScaling;

    try {
      final mediaQuery = MediaQuery.of(context);
      _mediaQueryData = mediaQuery;
      _pixelRatio = mediaQuery.devicePixelRatio;
      _screenWidthDp = mediaQuery.size.width;
      _screenHeightDp = mediaQuery.size.height;
      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = _mediaQueryData?.padding.bottom;
      _textScaleFactor = mediaQuery.textScaleFactor;
    } catch (_) {
      _pixelRatio = 0;
      _screenWidthDp = 0;
      _screenHeightDp = 0;
      _statusBarHeight = 0;
      _bottomBarHeight = 0;
      _textScaleFactor = 0;
    }
  }

  static double get screenWidthDp => (_screenWidthDp ?? 0);

  static double get screenHeightDp => (_screenHeightDp ?? 0);

  static double get pixelRatio => (_pixelRatio ?? 0);

  static double get statusBarHeight => (_statusBarHeight ?? 0);

  static double get bottomBarHeight => (_bottomBarHeight ?? 0);

  static double get textScaleFactor => (_textScaleFactor ?? 1);

  ///The vertical extent of this size. dp
  static double get screenHeightSafe =>
      screenHeight - (statusBarHeight) - (bottomBarHeight);

  /// The vertical extent of this size. px
  // ignore: recursive_getters
  static double get screenWidth => screenWidth * pixelRatio;

  /// The vertical extent of this size. px
  // ignore: recursive_getters
  static double get screenHeight => screenHeight * pixelRatio;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => screenWidth / (uiWidthPx ?? 1);

  double get scaleHeight => screenHeight / (uiHeightPx ?? 1);

  double get scaleText => scaleWidth;

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  num setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to
  /// achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect,
  ///  or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///Font size adaptation method
  num setSp(num fontSize, {bool? allowFontScalingSelf}) =>
      ((allowFontScaling ?? false) || (allowFontScalingSelf ?? false))
          ? (fontSize * scaleText)
          : (fontSize * scaleText) / textScaleFactor;
}
