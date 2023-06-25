import 'package:flutter/cupertino.dart';
import 'package:qrcode/feature/feature/scan_product/scan_qr.dart';

import '../../../../common/const/icon_constant.dart';
import '../../../../common/navigation/route_names.dart';
import '../../history_scan/history_scan_screen.dart';
import '../../home/home_screen.dart';
import '../../news/news_screen.dart';
import '../../personal/personal_screen.dart';

enum BottomBarEnum {
  home,
  lichSuQuet,
  scan,
  tinTuc,
  caNhan,
}

extension BottomBarEx on BottomBarEnum {
  String get getIcon {
    switch (this) {
      case BottomBarEnum.home:
        return IconConst.home;
      case BottomBarEnum.lichSuQuet:
        return IconConst.lichSuQuet;
      case BottomBarEnum.scan:
        return '';
      case BottomBarEnum.tinTuc:
        return IconConst.tinTuc;
      case BottomBarEnum.caNhan:
        return IconConst.caNhan;
    }
  }

  Widget get getScreen {
    switch (this) {
      case BottomBarEnum.home:
        return const HomeNested();
      case BottomBarEnum.lichSuQuet:
        return const ScanHistoryNested();
      case BottomBarEnum.scan:
        return const ScanQrNested();
      case BottomBarEnum.tinTuc:
        return const NewsNested();
      case BottomBarEnum.caNhan:
        return const PersonalNested();
    }
  }

  String get getRouteNames {
    switch (this) {
      case BottomBarEnum.home:
        return RouteName.homeScreen;
      case BottomBarEnum.lichSuQuet:
        return RouteName.historyScanScreen;
      case BottomBarEnum.scan:
        return RouteName.scanQrScreen;
      case BottomBarEnum.tinTuc:
        return RouteName.newsScreen;
      case BottomBarEnum.caNhan:
        return RouteName.personalScreen;
    }
  }
}
