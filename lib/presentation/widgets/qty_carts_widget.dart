import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/managers/style_manager.dart';

import '../../app/app.dart';

Widget qtyCartsWidget({double? size, double? textSize, int? qtyCustom}) {
  print(SessionUtils.qtyCartsList.toSet().toList());

  String count;

  if (qtyCustom != null && qtyCustom < 10) {
    count = qtyCustom.toString();
  } else {
    count =
        SessionUtils.qtyCarts < 10 ? SessionUtils.qtyCarts.toString() : '9+';
  }

  if (count == '0' || count.isEmpty) {
    return const SizedBox.shrink();
  }

  return Positioned(
    top: 0,
    right: 0,
    child: ClipOval(
      child: Container(
        width: (size ?? 12).r,
        height: (size ?? 12).r,
        color: Colors.red,
        child: Center(
          child: Text(
            count,
            style: TextStyleManager.medium.copyWith(
              color: Colors.white,
              fontSize: (textSize ?? 7).sp,
            ),
          ),
        ),
      ),
    ),
  );
}
