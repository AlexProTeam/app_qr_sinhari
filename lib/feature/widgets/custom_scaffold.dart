import 'package:flutter/material.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

const double defaultAppbar = 56.0;

class CustomScaffold extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? customAppBar;
  final Widget? body;
  final Widget? appbarWidget;
  final bool autoDismissKeyboard;
  final bool? resizeToAvoidBottomInset;
  final bool paddingBottom;

  const CustomScaffold({
    Key? key,
    this.backgroundColor,
    this.customAppBar,
    this.body,
    this.appbarWidget,
    this.autoDismissKeyboard = false,
    this.paddingBottom = true,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      body: Column(
        children: [
          customAppBar ??
              (appbarWidget ?? SizedBox(height: GScreenUtil.statusBarHeight)),
          const Divider(height: 1, color: AppColors.grey5),
          Expanded(
            child: GestureDetector(
                onTap: autoDismissKeyboard
                    ? () {
                        CommonUtil.dismissKeyBoard(context);
                      }
                    : () {},
                child: body ?? const SizedBox()),
          ),
          SizedBox(height: paddingBottom ? GScreenUtil.bottomBarHeight : 0),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? iconLeft;
  final Function? iconLeftTap;
  final bool stylePrimary;
  final bool hasShadow;
  final Widget? widgetRight;
  final bool haveIconLeft;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.iconLeft,
    this.iconLeftTap,
    this.stylePrimary = false,
    this.hasShadow = true,
    this.widgetRight,
    this.haveIconLeft = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          haveIconLeft
              ? GestureDetector(
                  onTap: () => iconLeftTap != null
                      ? iconLeftTap!()
                      : Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 20, top: 16, bottom: 16),
                    child: Center(
                        child: Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: Color(0xFFACACAC),
                    )),
                  ),
                )
              : const SizedBox(
                  width: 60,
                ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextTheme.mediumBlack,
            ),
          ),
          widgetRight ??
              const SizedBox(
                width: 60,
              )
        ],
      ),
    );
  }
}
