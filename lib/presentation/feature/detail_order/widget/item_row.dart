import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';

class ItemRow extends StatelessWidget {
  final String title;
  final TextStyle? textStyleTitle;
  final String value;
  final TextStyle? textStyleValue;

  const ItemRow(
      {Key? key,
      required this.title,
      this.textStyleTitle,
      required this.value,
      this.textStyleValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: textStyleTitle ??
                TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.black,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textStyleValue ??
                TextStyleManager.mediumBlack14px.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
