import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class ToastManager {
  static Future<void> showToast(
    BuildContext context, {
    required String text,
    int delaySecond = 2,
    Function()? afterShowToast,
  }) async {
    final alert = AlertDialog(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.topCenter,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.primaryColor,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          height: 1.57,
          color: AppColors.white,
          letterSpacing: 0.3,
        ),
      ),
    );

    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        Future.delayed(
          Duration(seconds: delaySecond),
          () {
            if (context.mounted) {
              Navigator.maybePop(context);
            }
          },
        ).then((value) => afterShowToast?.call());

        return alert;
      },
    );
  }
}
