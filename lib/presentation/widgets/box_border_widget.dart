import 'package:flutter/material.dart';

Widget boxBorderApp({required Widget child}) => Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(
          8,
        )),
      ),
      child: child,
    );
