import 'package:flutter/cupertino.dart';
import 'package:qrcode/app/managers/config_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';

enum AppContact { facebook, titok, website }

extension LoginEx on AppContact {
  Widget getIcon() {
    switch (this) {
      case AppContact.facebook:
        return _icon(Assets.icons.facebook.path);
      case AppContact.titok:
        return _icon(Assets.icons.iconTictok.path);
      case AppContact.website:
        return _icon(Assets.images.logoMain.path);
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

  String get _getUrl =>
      '${ConfigManager.getInstance()}go_social?social_type=$name';
}

enum PolicyEnum { guide, introduce, policy }

extension ListScreebEx on PolicyEnum {
  String get getScreenTerms {
    switch (this) {
      case PolicyEnum.guide:
        return 'terms';
      case PolicyEnum.introduce:
        return 'introduce';
      case PolicyEnum.policy:
        return 'support_policy';
    }
  }

  String get getNameTerms {
    switch (this) {
      case PolicyEnum.guide:
        return 'Chính sách bán hàng';
      case PolicyEnum.introduce:
        return 'Chính sách bảo mật';
      case PolicyEnum.policy:
        return 'Điều khoản sử dụng';
    }
  }

  String get getSubTitleTerms {
    switch (this) {
      case PolicyEnum.guide:
        return 'Chính sách bán hàng';
      case PolicyEnum.introduce:
        return 'Chính sách bảo mật';
      case PolicyEnum.policy:
        return 'ĐIỀU KHOẢN BẢO MẬT &\nCHÍNH SACH ỨNG DỤNG';
    }
  }
}
