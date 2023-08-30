import 'package:flutter/material.dart';

import '../../../../common/const/icon_constant.dart';
import '../../../../common/navigation/route_names.dart';

enum PersonalContactEnum {
  account,
  contact,
  provisionOrder,
  provisionSecurity,
  adjust
}

extension PersonalContactEnumEx on PersonalContactEnum {
  Widget getIcon() {
    switch (this) {
      case PersonalContactEnum.account:
        return _icon(IconConst.info);
      case PersonalContactEnum.contact:
        return _icon(IconConst.contact);
      case PersonalContactEnum.provisionOrder:
        return _icon(IconConst.provisionOrder);
      case PersonalContactEnum.provisionSecurity:
        return _icon(IconConst.provisionSecurity);
      case PersonalContactEnum.adjust:
        return _icon(IconConst.adjust);
    }
  }

  String get getDisplayValue {
    switch (this) {
      case PersonalContactEnum.account:
        return 'Thông tin cá nhân';
      case PersonalContactEnum.contact:
        return 'Liên hệ';
      case PersonalContactEnum.provisionOrder:
        return 'Chính sách bán hàng';
      case PersonalContactEnum.provisionSecurity:
        return 'Chính sách bảo mật';
      case PersonalContactEnum.adjust:
        return 'Điều khoản sử dụng';
    }
  }

  Object getOnTap(BuildContext context) {
    switch (this) {
      case PersonalContactEnum.account:
        return Navigator.pushNamed(context, RouteName.profileScreen);
      case PersonalContactEnum.contact:
        return Navigator.pushNamed(context, RouteName.webViewScreen,
            arguments: 'https://sinhairvietnam.vn/lien-he/');
      case PersonalContactEnum.provisionOrder:
        return Navigator.pushNamed(context, RouteName.policyScreen,
            arguments: 'Screen1');
      case PersonalContactEnum.provisionSecurity:
        return Navigator.pushNamed(context, RouteName.policyScreen,
            arguments: 'Screen2');
      case PersonalContactEnum.adjust:
        return Navigator.pushNamed(context, RouteName.policyScreen,
            arguments: 'Screen3');
    }
  }

  Widget _icon(String icon) => Image.asset(
        icon,
        width: 30,
        height: 30,
      );
}
