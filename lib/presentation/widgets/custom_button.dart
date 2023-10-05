import 'package:flutter/material.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/style_manager.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final double? width;
  final double? height;
  final double? radius;
  final TextStyle? styleTitle;

  const CustomButton(
      {Key? key,
      this.text,
      this.height,
      this.width,
      required this.onTap,
      this.radius,
      this.styleTitle})
      : super(key: key);

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
            style: styleTitle ??
                TextStyleManager.normalWhite.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
          ),
        ),
      ),
    );
  }
}
