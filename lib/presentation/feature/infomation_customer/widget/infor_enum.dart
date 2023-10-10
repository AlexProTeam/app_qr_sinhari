import 'dart:ui';

import 'package:qrcode/app/managers/color_manager.dart';

enum ButtonEnum { dangxuly, congno, pending }

class HelperInfor {
  static Color getColor(String title) {
    switch (title) {
      case 'pending':
        return AppColors.blue;
      case 'processing':
        return AppColors.green;
      case 'completed':
        return AppColors.red;
      case 'canceled':
        return AppColors.red;
      default:
        return AppColors.grey7;
    }
  }
}
