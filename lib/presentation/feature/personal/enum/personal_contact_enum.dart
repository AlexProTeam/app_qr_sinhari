import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/route_names.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/personal/enum/personal_menu_enum.dart';

enum PersonalContactEnum {
  account,
  contact,
  infoOrder,
  historyDebt,
  provisionOrder,
  provisionSecurity,
  adjust,
}

extension PersonalContactEnumEx on PersonalContactEnum {
  Widget getIcon() {
    switch (this) {
      case PersonalContactEnum.account:
        return _icon(
          Assets.icons.user.path,
        );
      case PersonalContactEnum.contact:
        return _icon(Assets.icons.contactSupport.path);
      case PersonalContactEnum.provisionOrder:
        return _icon(Assets.icons.adjust.path);
      case PersonalContactEnum.provisionSecurity:
        return _icon(Assets.icons.gppMaybe.path);
      case PersonalContactEnum.adjust:
        return _icon(Assets.icons.chatContact.path);
      case PersonalContactEnum.infoOrder:
        return _icon(Assets.icons.iconCard.path);
      case PersonalContactEnum.historyDebt:
        return _icon(Assets.icons.iconApp.path);
    }
  }

  String get getDisplayValue {
    switch (this) {
      case PersonalContactEnum.account:
        return 'Thông tin cá nhân';
      case PersonalContactEnum.contact:
        return 'Liên hệ';
      case PersonalContactEnum.infoOrder:
        return 'Thông tin đơn hàng';
      case PersonalContactEnum.historyDebt:
        return 'Lịch sử công nợ';
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
        return Navigator.pushNamed(context, RouteDefine.profileScreen);
      case PersonalContactEnum.contact:
        return Navigator.pushNamed(context, RouteDefine.webViewScreen,
            arguments: 'https://sinhairvietnam.vn/lien-he/');
      case PersonalContactEnum.provisionOrder:
        return Navigator.pushNamed(context, RouteDefine.policyScreen,
            arguments: PolicyEnum.guide);
      case PersonalContactEnum.provisionSecurity:
        return Navigator.pushNamed(context, RouteDefine.policyScreen,
            arguments: PolicyEnum.introduce);
      case PersonalContactEnum.adjust:
        return Navigator.pushNamed(context, RouteDefine.policyScreen,
            arguments: PolicyEnum.policy);
      case PersonalContactEnum.infoOrder:
        return Navigator.pushNamed(
          context,
          RouteDefine.informationCustomer,
        );
      case PersonalContactEnum.historyDebt:
        return Navigator.pushNamed(context, RouteDefine.historyDetb,
            arguments: PolicyEnum.policy);
    }
  }

  Widget _icon(String icon) => Image.asset(
        icon,
        width: 30,
        height: 30,
      );
}
