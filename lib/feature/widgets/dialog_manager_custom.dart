import 'package:flutter/material.dart';
import 'package:qrcode/feature/widgets/widget_loading.dart';

import '../routes.dart';

class DialogManager {
  static void get hideLoadingDialog {
    if (_dialogIsVisible(Routes.instance.navigatorKey.currentContext!)) {
      Navigator.of(Routes.instance.navigatorKey.currentContext!).pop();
    }
  }

  static bool _dialogIsVisible(BuildContext context) {
    bool isVisible = false;
    Navigator.popUntil(context, (route) {
      isVisible = route is PopupRoute;

      return !isVisible;
    });

    return isVisible;
  }

  static Future<void> showLoadingDialog(
    BuildContext context, {
    bool isBackgroundTransparent = true,
  }) async {
    final alert = AlertDialog(
      backgroundColor:
          isBackgroundTransparent ? Colors.transparent : Colors.white,
      shadowColor: isBackgroundTransparent ? Colors.transparent : Colors.white,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      content: const Center(
        child: SizedBox(
          width: 70,
          height: 70,
          child: WidgetLoading(),
        ),
      ),
    );
    if (!_dialogIsVisible(Routes.instance.navigatorKey.currentContext!)) {
      showDialog(
        barrierColor:
            isBackgroundTransparent ? Colors.transparent : Colors.white,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
