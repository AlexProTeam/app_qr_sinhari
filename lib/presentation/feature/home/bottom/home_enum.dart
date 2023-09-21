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
        return Assets.images.icon1.path;
      case IconHomeEnum.shampoo:
        return Assets.images.icon2.path;
      case IconHomeEnum.news:
        return Assets.images.icon3.path;
      case IconHomeEnum.favourite:
        return Assets.images.icon4.path;
      case IconHomeEnum.tool:
        return Assets.images.icon5.path;
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
