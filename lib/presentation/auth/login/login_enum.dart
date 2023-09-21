import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrcode/gen/assets.gen.dart';

enum LoginEnum { gmail, facebook, zalo, apple }

extension LoginEx on LoginEnum {
  Function() getOnTap() {
    switch (this) {
      case LoginEnum.gmail:
        return () {};
      case LoginEnum.facebook:
        return () {};
      case LoginEnum.zalo:
        return () {};
      case LoginEnum.apple:
        return () {};
    }
  }

  Widget getIcon() {
    switch (this) {
      case LoginEnum.gmail:
        return _icon(Assets.icons.gmail.path, getOnTap());
      case LoginEnum.facebook:
        return _icon(Assets.icons.facebook.path, getOnTap());
      case LoginEnum.zalo:
        return _icon(Assets.icons.zalo.path, getOnTap());
      case LoginEnum.apple:
        if (Platform.isAndroid) return const SizedBox.shrink();
        return _icon(Assets.icons.apple.path, getOnTap());
    }
  }

  Widget _icon(String icon, Function() onTap) => InkWell(
        onTap: onTap,
        child: Image.asset(
          icon,
          width: 30,
          height: 30,
        ),
      );
}
