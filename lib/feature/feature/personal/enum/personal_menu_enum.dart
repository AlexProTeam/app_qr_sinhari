import 'package:flutter/cupertino.dart';

import '../../../../common/const/icon_constant.dart';
import '../../../../common/network/configs.dart';

enum AppContact { facebook, titok, website }

extension LoginEx on AppContact {
  Widget getIcon() {
    switch (this) {
      case AppContact.facebook:
        return _icon(IconConst.facebook);
      case AppContact.titok:
        return _icon(IconConst.iconTictok);
      case AppContact.website:
        return _icon(IconConst.logoMain);
    }
  }

  String get getLongContact {
    switch (this) {
      case AppContact.facebook:
      case AppContact.titok:
      case AppContact.website:
        return _getUrl;
    }
  }

  String get getShortContact {
    switch (this) {
      case AppContact.facebook:
        return 'Dầu Gội Thải Độc Hương Nước Hoa Cao Cấp SinHair Saryyam';
      case AppContact.titok:
        return 'sinhair.saryyam';
      case AppContact.website:
        return 'sinhairvietnam.vn';
    }
  }

  String get getNameContact {
    switch (this) {
      case AppContact.facebook:
        return 'Facebook';
      case AppContact.titok:
        return 'Tictok';
      case AppContact.website:
        return 'website công ty';
    }
  }

  Widget _icon(String icon) => Image.asset(
        icon,
        width: 30,
        height: 30,
      );

  String get _getUrl => '${Configurations.host}go_social?social_type=$name';
}
