import 'package:flutter/cupertino.dart';

import '../../../../common/const/icon_constant.dart';

enum AppContact { facebook, tictok, website }

extension LoginEx on AppContact {
  Widget getIcon() {
    switch (this) {
      case AppContact.facebook:
        return _icon(IconConst.facebook);
      case AppContact.tictok:
        return _icon(IconConst.iconTictok);
      case AppContact.website:
        return _icon(IconConst.logo);
    }
  }

  String get getLongContact {
    switch (this) {
      case AppContact.facebook:
        return 'https://admin.sinhairvietnam.vn/go_social?social_type=facebook';
      case AppContact.tictok:
        return 'https://admin.sinhairvietnam.vn/go_social?social_type=titok';
      case AppContact.website:
        return 'https://admin.sinhairvietnam.vn/go_social?social_type=website';
    }
  }

  String get getShortContact {
    switch (this) {
      case AppContact.facebook:
        return 'Dầu Gội Thải Độc Hương Nước Hoa Cao Cấp SinHair Saryyam';
      case AppContact.tictok:
        return 'sinhair.saryyam';
      case AppContact.website:
        return 'sinhairvietnam.vn';
    }
  }

  String get getNameContact {
    switch (this) {
      case AppContact.facebook:
        return 'Facebook';
      case AppContact.tictok:
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
}
