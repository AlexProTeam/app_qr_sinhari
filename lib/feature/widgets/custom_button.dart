import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

import '../themes/theme_color.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final double? width;
  final double? height;
  final double? radius;

  const CustomButton({
    Key? key,
    this.text,
    this.height,
    this.width,
    required this.onTap,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 313,
        height: height ?? 50,
        decoration: BoxDecoration(
            color: AppColors.colorEF4948,
            borderRadius: BorderRadius.circular(radius ?? 20)),
        child: Center(
          child: Text(
            text ?? '',
            style: AppTextTheme.normalWhite.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
