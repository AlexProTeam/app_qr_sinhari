import '../../../../app/managers/const/icon_constant.dart';

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
        return IconConst.icon1;
      case IconHomeEnum.shampoo:
        return IconConst.icon2;
      case IconHomeEnum.news:
        return IconConst.icon3;
      case IconHomeEnum.favourite:
        return IconConst.icon4;
      case IconHomeEnum.tool:
        return IconConst.icon5;
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
