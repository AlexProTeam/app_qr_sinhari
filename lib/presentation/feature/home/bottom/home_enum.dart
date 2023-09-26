import 'package:qrcode/gen/assets.gen.dart';

enum IconHomeEnum {
  all,
  shampoo,
  news,
  favourite,
  tool,
}

extension IconHomeEx on IconHomeEnum {
  String get getIcon {
    switch (this) {
      case IconHomeEnum.all:
        return Assets.icons.icon1.path;
      case IconHomeEnum.shampoo:
        return Assets.icons.icon2.path;
      case IconHomeEnum.news:
        return Assets.icons.icon3.path;
      case IconHomeEnum.favourite:
        return Assets.icons.icon4.path;
      case IconHomeEnum.tool:
        return Assets.icons.icon5.path;
    }
  }

  String get getTitle {
    switch (this) {
      case IconHomeEnum.all:
        return 'Tất cả';
      case IconHomeEnum.shampoo:
        return 'Dầu gội';
      case IconHomeEnum.news:
        return 'Tin tức';
      case IconHomeEnum.favourite:
        return 'Yêu thích';
      case IconHomeEnum.tool:
        return 'Dụng cụ';
    }
  }
}
