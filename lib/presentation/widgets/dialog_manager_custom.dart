// Project imports:
part of app_layer;

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

  static Future<void> showDialogCustom({
    String? rightTitle,
    String? leftTitle,
    String? content,
    String? title,
    required Function onTapRight,
    required Function onTapLeft,
    Color? bgColorLeft,
    Color? bgColorRight,
    Widget? icon,
    required BuildContext context,
    bool isBackgroundTransparent = true,
    TextStyle? styleLeft,
    TextStyle? styleRight,
    TextStyle? styleContent,
  }) async {
    final alert = Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: DialogDoubleButtonAction(
        onTapRight: () {
          onTapRight();
        },
        onTapLeft: () {
          onTapLeft();
        },
        title: title,
        rightTitle: rightTitle,
        leftTitle: leftTitle,
        content: content,
        bgColorLeft: bgColorLeft,
        bgColorRight: bgColorRight,
        icon: icon,
        styleContent: styleContent,
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

  static Future<bool> showDialogConfirm(
    BuildContext context, {
    required Function() onTapLeft,
    required String content,
    required String leftTitle,
  }) async {
    bool data = false;

    await showDialogCustom(
      icon: Image.asset(Assets.icons.icQuesition.path),
      onTapRight: () {
        data = false;
      },
      onTapLeft: () {
        data = true;
        onTapLeft();
      },
      leftTitle: leftTitle,
      rightTitle: 'Huỷ',
      context: context,
      bgColorLeft: AppColors.realEstate,
      bgColorRight: AppColors.red,
      content: content,
      styleContent: kTextRegularStyle.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );

    return data;
  }
}
