import 'package:flutter/material.dart';

class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const blue = Colors.blue;
  static const Color primaryColor = Color(0xffC38B20);
  static const Color mainRed = Color(0xffeb4571);
  static const Color grey2 = Color(0xffFAFAFA);
  static const Color grey3 = Color(0xffF5F5F5);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey4 = Color(0xffE8E8E8);
  static const Color grey6 = Color(0xffBFBFBF);
  static const Color grey5 = Color(0xffD9D9D9);
  static const Color grey7 = Color(0xff8C8C8C);
  static const Color grey8 = Color(0xff595959);
  static const Color grey9 = Color(0xff2A1933);
  static const Color pink = Color(0xffEA3C71);
  static const Color red1 = Color(0xffFFF1F0);
  static const Color red2 = Color(0xffFFCCC7);
  static const Color red5 = Color(0xffFF4D4F);
  static const Color red6 = Color(0xffF5222D);
  static const Color red = Color(0xffF5061B);
  static const Color yellow = Color(0xffFFA940);
  static const Color green = Color(0xff4DD077);
  static const Color green1 = Color(0xffEBFAEF);
  static const Color greenText = Color(0xff3FBA95);
  static const Color lightGreen = Color(0xff8CE1A7);
  static const Color backgroundGrey = Color(0xffFAFAFA);
  static const Color colorSun = Color(0xffFFD666);
  static const Color colorGoogle = Color(0xffdb3236);
  static const Color colorDivider = grey5;
  static const Color colorEF4948 = Color(0xFFEF4948);
  static const Color colorF4F5FB = Color(0xFFF4F5FB);
  static const Color bgrScafold = Color(0xFFF2F2F2);
  static const Color color2604F5 = Color(0xFF2604F5);
  static const Color color0A55BA = Color(0xFF0A55BA);
  static const Color colorC4C4C4 = Color(0xFFC4C4C4);
  static const Color color95B9EE = Color(0xFF95B9EE);
  static const Color color064CFC = Color(0xFF064CFC);
  static const Color color7F2B81 = Color(0xFF7F2B81);
  static const Color color777777 = Color(0xFF777777);

  // splash
  static const Color splashNotFocusDot = Color(0xffE8E8E8);

  // registration
  static const Color backgroundIconBack = Color(0xffF5F5F5);
  static const Color colorBorder = Color(0xffE8E8E8);

  // color category
  static const Color fashion = Color(0xff36CFC9);
  static const Color realEstate = Color(0xff597EF7);
  static const Color vehicle = Color(0xffFFA940);
  static const Color phone = Color(0xffF759AB);
  static const Color laptop = Color(0xff9C27B0);
  static const Color electronic = Color(0xff673AB7);
  static const Color service = Color(0xfff44336);
  static const Color food = Color(0xffFFC53D);
  static const Color drink = Color(0xffCDDC39);
  static const Color pet = Color(0xff795548);
  static const Color education = Color(0xff009688);
  static const Color book = Color(0xff03A9F4);
  static const Color gift = Color(0xff4DD077);
  static const Color persons = Color(0xff607D8B);
  static const Color momAndBaby = Color(0xff4CAF50);
  static const Color sport = Color(0xffb71c1c);
  static const Color furniture = Color(0xff9E9E9E);
  static const Color job = Color(0xff096DD9);
  static const Color rent = Color(0xffFF7A45);
  static const Color grocery = Color(0xff212121);
  static const Color house = Color(0xffD500F9);
  static const Color other = Color(0xff01579B);
  static const Color colorACACAC = Color(0xffACACAC);
  static const Color colorFFC700 = Color(0xFFFFC700);
  static const Color colorE7E7E7 = Color(0xFFE7E7E7);
  static const Color colorCA1010 = Color(0xFFCA1010);
  static const Color colorF1F1F1 = Color(0xFFF1F1F1);
  static const Color color000AFF = Color(0xFF000AFF);
  static const Color color0A6CFF = Color(0xFF0A6CFF);

  // color logo
  static const Color logoPink = Color(0xffe94776);
  static const Color logoYellow = Color(0xfff0bd50);
  static const Color logoSkyBlue = Color(0xff57c7ec);
  static const Color logoGreen = primaryColor;

  static const List<Color> colorsGradient = [
    logoPink,
    logoYellow,
    logoGreen,
    logoSkyBlue
  ];
}

extension HexColor on Color {
  static Color fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    return Color(int.parse(hexColor, radix: 16));
  }
}
//new colors

// surface
const kSurfaceDefaultColor = Color(0xFFFFFFFF);
const kSurfaceSubduedColor = Color(0xFFE7F7FD);
const kSurfaceMediumColor = Color(0xFFF6F6F7);
const kSurfaceDisabledColor = Color(0xFFEDEEEF);
const kSurfaceCriticalColor = Color(0xFFEC3A39);
const kSurfaceWarningColor = Color(0xFFFFB020);
const kSurfaceSuccessColor = Color(0xFF52BD94);
const kSurfaceHighlightColor = Color(0xFF3366FF);
const kSurfacePrimaryColor = Color(0xFF0BA4EE);
const kSurfacePrimarySubdueColor = Color(0xFFE7F6FD);
const kSurfaceCriticalSubdueColor = Color(0xFFFCEEEE);
const kSurfaceWarningSubdueColor = Color(0xFFFFF5EA);
const kSurfaceSuccessSubdueColor = Color(0xFFEDF8F2);
const kSurfaceHighlightSubdueColor = Color(0xFFF0F4FF);
const kSurfaceWarningPressedColor = Color(0xFFFFD079);
const kSurfaceCriticalPressedColor = Color(0xFFEE9191);
const kSurfaceSuccessPressedColor = Color(0xFFA3E6CD);
const kSurfaceHighlightPressedColor = Color(0xFF9DB5FF);
const kSurfacePrimaryPressedColor = Color(0xFF5AC2F4);
const kSurfaceActiveColor = Color(0xFF4BBFF6);
const kSurfaceLightPrimarySubdueColor = Color(0xFFE3F4FD);
const kSurfaceLightSubdueColor = Color(0xFFF9FAFB);

//background
const kBackGroundDefaultColor = Color(0xFFF6F6F7);
const kBackGroundHoveredColor = Color(0xFFF1F2F3);
const kBackGroundPressedColor = Color(0xFFEDEEEF);
const kBackGroundSelectedColor = Color(0xFF101840);

// text
const kTextDefaultColor = Color(0xFF101840);
const kTextMediumColor = Color(0xFF696F8C);
const kTextSubduedColor = Color(0xFF979DB9);
const kTextDisabledColor = Color(0xFFC1C4D6);
const kTextCriticalColor = Color(0xFFF62D2D);
const kTextWarningColor = Color(0xFFFFB020);
const kTextSuccessColor = Color(0xFF52BD94);
const kTextHighlightColor = Color(0xFF3366FF);
const kTextPrimaryColor = Color(0xFF0BA4EE);
const kTextBackColor = Color(0xFF020303);

// icons
const kIconDefaultColor = Color(0xFF101840);
const kIconSubduedColor = Color(0xFF696F8C);
const kIconPressedColor = Color(0xFF474D66);
const kIconDisabledColor = Color(0xFFC1C4D6);
const kIconCriticalColor = Color(0xFFF62D2D);
const kIconWarningColor = Color(0xFFFFB020);
const kIconSuccessColor = Color(0xFF52BD94);
const kIconHighlightColor = Color(0xFF367CF8);
const kIconPrimaryColor = Color(0xFF0BA4EE);
const kIconCriticalRedColor = Color(0xFFE24C4C);
//border
const kBorderDefaultColor = Color(0xFFE6E8F0);
const kBorderSubduedColor = Color(0xFFEDEFF5);
const kBorderDividerColor = Color(0xFFD8DAE5);
const kBorderDisabledColor = Color(0xFFEDEFF5);
const kBorderCriticalColor = Color(0xFFF62D2D);
const kBorderWarningColor = Color(0xFFFFB020);
const kBorderSuccessColor = Color(0xFF52BD94);
const kBorderHighlightColor = Color(0xFF367CF8);
// const kBorderPrimaryColor = Color(0xFF0BA4EE);
const kBorderPrimarySubdueColor = Color(0xFFD3F5F7);
const kBorderCriticalSubdueColor = Color(0xFFF9DADA);
const kBorderWarningSubdueColor = Color(0xFFFFEFD2);
const kBorderSuccessSubdueColor = Color(0xFFEEF8F4);
const kBorderHighlightSubdueColor = Color(0xFFEBF0FF);
const kBorderPrimaryColor = Color(0xFF4BBFF6);
const kBGColor = Color(0xFFFFF5EB);
//
const kD9FAFBColor = Color(0xFFD9FAFB);
const kF0512E = Color(0xFFF0512E);
const k3EA7FF = Color(0xFF3EA7FF);

//bank

const kVcbColor = Color(0xFF6FB145);

//dark mode
const kBackgroundDarkmode = Color(0xFF0B265D);
const kBackgroundThemeDarkmode = Color(0xFF071D4A);
const kBackgroundItemDarkmode = Color(0xFF18306D);
const kBordermDarkmode = Color(0xFF35497D);
const kBackgroundInvoiceDarkmode = Color(0xFF263B75);
const kBackgroundWalletDarkmode = Color(0xFF20356E);
const k0B1F4FColor = Color(0xFF0B1F4F);

Color kThemeColorIcon = kTextBackColor;

const kMyFont = 'BeVietnamPro';

var kTextHeadingStyle = const TextStyle(
    fontFamily: kMyFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white);

var kTextRegularStyle = TextStyle(
    fontFamily: kMyFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kThemeColorIcon);

var kTextMediumtStyle = TextStyle(
    fontFamily: kMyFont,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: kThemeColorIcon);

const kTextDisableStyle = TextStyle(
    fontFamily: kMyFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: kTextDisabledColor);

const kTextCriticalStyle = TextStyle(
    fontFamily: kMyFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kTextCriticalColor);

const kTextButtonStyle = TextStyle(
    fontFamily: kMyFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kTextDefaultColor);
