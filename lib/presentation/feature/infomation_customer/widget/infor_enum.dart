import 'dart:ui';

import 'package:qrcode/app/managers/color_manager.dart';

enum ButtonEnum { dangxuly, congno }

class HelperInfor {
  static Color getColor(String title) {
    switch (title) {
      case 'Đang xử lý':
        return AppColors.colorC4C4C4;
      case 'Công nợ':
        return AppColors.red;
      default:
        return AppColors.colorC4C4C4;
    }
  }
}
