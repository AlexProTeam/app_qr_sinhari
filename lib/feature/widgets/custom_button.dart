import 'package:flutter/material.dart';
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
            color: const Color(0xFFEF4948),
            borderRadius: BorderRadius.circular(20)),
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
