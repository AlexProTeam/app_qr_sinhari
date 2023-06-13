import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

class Welcome3Point extends StatelessWidget {
  final int currentIndex;

  const Welcome3Point({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Row(
          children: [
            _point(0),
            const SizedBox(width: 12),
            _point(1),
            const SizedBox(width: 12),
            _point(2),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _point(int index) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? AppColors.white : AppColors.grey4,
      ),
    );
  }
}
