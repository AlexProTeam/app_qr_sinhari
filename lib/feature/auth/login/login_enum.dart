import 'dart:io';

import 'package:flutter/material.dart';

import '../../../common/const/icon_constant.dart';

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
        return _icon(IconConst.gmail, getOnTap());
      case LoginEnum.facebook:
        return _icon(IconConst.facebook, getOnTap());
      case LoginEnum.zalo:
        return _icon(IconConst.zalo, getOnTap());
      case LoginEnum.apple:
        if (Platform.isAndroid) return const SizedBox.shrink();
        return _icon(IconConst.apple, getOnTap());
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
