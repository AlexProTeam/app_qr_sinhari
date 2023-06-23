import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

class PointWidget extends StatelessWidget {
  final int currentIndex;
  final int dotSize;

  const PointWidget(
      {Key? key, required this.currentIndex, required this.dotSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(dotSize, (index) => _point(index)),
      );

  Widget _point(int index) => Container(
        margin: index == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 12),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? AppColors.white : AppColors.grey4,
        ),
      );
}
