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
