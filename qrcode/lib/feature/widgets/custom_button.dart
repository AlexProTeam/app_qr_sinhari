import 'package:flutter/material.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function onTap;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    this.text,
    this.height,
    this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 313,
        height: height ?? 50,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: StringConst.defaultShadow),
        child: Center(
          child: Text(
            text ?? '',
            style: AppTextTheme.normalWhite.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
