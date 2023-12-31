import 'package:flutter/cupertino.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../../app/managers/route_names.dart';
import '../../history_scan/ui/history_scan_screen.dart';
import '../../home/home_screen.dart';
import '../../news/news_screen/ui/news_screen.dart';
import '../../personal/personal_screen.dart';
import '../../scan_product/scan_qr.dart';

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
        return Assets.images.home.path;
      case BottomBarEnum.lichSuQuet:
        return Assets.images.clock.path;
      case BottomBarEnum.scan:
        return '';
      case BottomBarEnum.tinTuc:
        return Assets.images.paper.path;
      case BottomBarEnum.caNhan:
        return Assets.images.user.path;
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
        return RouteDefine.homeScreen;
      case BottomBarEnum.lichSuQuet:
        return RouteDefine.historyScanScreen;
      case BottomBarEnum.scan:
        return RouteDefine.scanQrScreen;
      case BottomBarEnum.tinTuc:
        return RouteDefine.newsScreen;
      case BottomBarEnum.caNhan:
        return RouteDefine.personalScreen;
    }
  }
}
