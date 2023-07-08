import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

class WidgetLoading extends StatelessWidget {
  const WidgetLoading({
    Key? key,
    this.strokeWidth = 5,
    this.size = 50,
    this.havePaddingKeyboard = false,
  }) : super(key: key);

  final double strokeWidth;
  final double size;
  final bool havePaddingKeyboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: havePaddingKeyboard
          ? EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            )
          : EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
