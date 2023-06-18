import '../../../../common/const/icon_constant.dart';

enum ScanTypeEnum {
  image,
  product,
  invoice,
}

extension IconHomeEx on ScanTypeEnum {
  String get getIcon {
    switch (this) {
      case ScanTypeEnum.image:
        return IconConst.scanImage;
      case ScanTypeEnum.product:
        return IconConst.scanProduct;
      case ScanTypeEnum.invoice:
        return IconConst.scanInvoice;
    }
  }

  String get getTitle {
    switch (this) {
      case ScanTypeEnum.image:
        return 'Quét hình';
      case ScanTypeEnum.product:
        return 'Quét sản phẩm';
      case ScanTypeEnum.invoice:
        return 'Quét đơn';
    }
  }
}
