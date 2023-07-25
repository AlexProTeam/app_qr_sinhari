import 'package:flutter/material.dart';

import '../themes/theme_text.dart';

Widget iconTextWidget({
  Widget? iconWidget,
  required Function() onTap,
  required String text,
  String? iconData,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: iconWidget ??
                  Image.asset(
                    iconData ?? '',
                    width: 20,
                    height: 20,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTextTheme.normalBlack.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    ),
  );
}
