import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';

class ContainerDrawerItem extends StatelessWidget {
  final String? name;
  final Function? onTap;

  const ContainerDrawerItem({Key? key, this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              name ?? '',
              style: AppTextTheme.normalGrey,
            )),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
