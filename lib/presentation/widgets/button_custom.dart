import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qrcode/app/managers/color_manager.dart';

enum StateButton { active, pressed, disable }

class ActionButton extends StatelessWidget {
  ActionButton({
    Key? key,
    this.height,
    this.width,
    this.title,
    required this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.prefixIcon,
    this.rightIcon,
  }) : super(key: key);

  final double? height;
  final double? width;
  final String? title;
  final Color? backgroundColor;
  final Color? titleColor;
  final Function onTap;
  final Widget? prefixIcon;
  final Widget? rightIcon;
  int timeClick = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height ?? 48,
        width: width ?? 1.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor ?? kSurfacePrimaryColor),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) prefixIcon!,
              if (prefixIcon != null)
                const SizedBox(
                  width: 16,
                ),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: kTextButtonStyle.copyWith(
                    color: titleColor ?? Colors.white, fontSize: 16),
              ),
              if (rightIcon != null)
                const SizedBox(
                  width: 8,
                ),
              if (rightIcon != null) rightIcon!,
            ],
          ),
        ),
      ),
    );
  }
}

class DialogDoubleButtonAction extends StatelessWidget {
  final String? rightTitle;
  final String? leftTitle;
  final String? title;
  final String? content;
  final Function onTapLeft;
  final Function onTapRight;
  final Color? bgColorLeft;
  final Color? bgColorRight;
  final Widget? icon;
  final TextStyle? styleLeft;
  final TextStyle? styleRight;
  final TextStyle? styleContent;

  const DialogDoubleButtonAction(
      {Key? key,
      this.rightTitle,
      this.leftTitle,
      this.content,
      this.title,
      required this.onTapRight,
      required this.onTapLeft,
      this.bgColorLeft,
      this.bgColorRight,
      this.icon,
      this.styleContent,
      this.styleLeft,
      this.styleRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Container(
              child: icon,
            ),
          if (icon == null)
            Text(
              title ?? '',
              style: kTextHeadingStyle.copyWith(
                  fontSize: 20, color: kIconDefaultColor),
            ),
          const SizedBox(height: 16),
          Text(
            content ?? '',
            textAlign: TextAlign.center,
            style: styleContent ??
                kTextRegularStyle.copyWith(color: kTextMediumColor),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ActionButton(
                  backgroundColor: bgColorLeft ?? kSurfacePrimarySubdueColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    Navigator.pop(context);
                    onTapLeft();
                  },
                  title: leftTitle ?? "ok",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ActionButton(
                  backgroundColor: bgColorRight ?? kSurfacePrimarySubdueColor,
                  titleColor: AppColors.white,
                  onTap: () {
                    Navigator.pop(context);
                    onTapRight();
                  },
                  title: rightTitle ?? "ok",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {Key? key,
      this.height,
      this.width,
      this.title,
      this.state = StateButton.active,
      required this.onTap,
      this.customContent,
      this.color,
      this.titleColor,
      this.border,
      this.borderRadius})
      : super(key: key);

  final double? height;
  final double? width;
  final String? title;
  final StateButton state;
  final Function onTap;
  final Widget? customContent;
  final Color? color;
  final Color? titleColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;

  int timeClick = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (state != StateButton.disable) {
          FocusScope.of(Get.context ?? context).unfocus();
          if (timeClick == 0) {
            timeClick = 1;
            onTap();
            Future.delayed(const Duration(milliseconds: 500), () {
              timeClick = 0;
            });
          }
        }
      },
      child: Container(
        height: height ?? 48,
        width: width ?? 1.sw,
        decoration: BoxDecoration(
            border: border,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            color: color ?? getBackgroundColor(state)),
        child: Center(
          child: customContent ??
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: kTextButtonStyle.copyWith(
                    color: titleColor ?? getTitleColor(state)),
              ),
        ),
      ),
    );
  }

  Color getBackgroundColor(StateButton state) {
    switch (state) {
      case StateButton.active:
        return kSurfacePrimaryColor;
      case StateButton.pressed:
        return kSurfaceMediumColor;
      default:
        return kSurfaceDisabledColor;
    }
  }

  Color getTitleColor(StateButton state) {
    switch (state) {
      case StateButton.disable:
        return kTextDisabledColor;
      default:
        return Colors.white;
    }
  }
}
