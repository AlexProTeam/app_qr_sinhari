import 'package:flutter/material.dart';

Widget titleValueWidget({
  required String icon,
  required String title,
  required String value,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon.isNotEmpty)
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
        const SizedBox(width: 15),
        Padding(
          padding: EdgeInsets.only(top: icon.isNotEmpty ? 2.5 : 0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: icon.isNotEmpty ? 2.5 : 0),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
