import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/style_manager.dart';
import '../../app/route/common_util.dart';
import '../../app/route/screen_utils.dart';

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
          Expanded(
            child: GestureDetector(
                onTap: autoDismissKeyboard
                    ? () {
                        CommonUtil.dismissKeyBoard(context);
                      }
                    : () {},
                child: body ?? const SizedBox()),
          ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 20, top: 16, bottom: 16),
                    child: Center(
                        child: Icon(
                      Icons.arrow_back,
                      size: 18.r,
                      color: AppColors.colorACACAC,
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
              style: TextStyleManager.mediumBlack.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
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

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isShowBack;
  @override
  final Size preferredSize;
  final Widget? leadingIcon;
  final String? title;
  final Color? backGroundColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? tabbar;
  final bool? refreshData;
  final Widget? widgetTitle;
  final double? leadingWidth;
  final Color? titleColor;

  BaseAppBar({
    Key? key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.tabbar,
    this.backGroundColor,
    this.isShowBack = false,
    this.refreshData,
    this.widgetTitle,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.leadingWidth,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      backgroundColor: backGroundColor ?? Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      bottomOpacity: 0.0,
      elevation: 0,
      shadowColor: Colors.transparent,
      bottom: tabbar,
      automaticallyImplyLeading: false,
      title: widgetTitle ??
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyleManager.mediumBlack.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
      centerTitle: true,
      leading: leadingWidget(context),
      actions: actions,
    );
  }

  Widget leadingWidget(BuildContext context) {
    if (leadingIcon != null) {
      return leadingIcon ?? const SizedBox();
    }
    if (isShowBack) {
      return InkWell(
        onTap: () {
          Navigator.pop(context, refreshData);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.grey,
          size: 24,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
