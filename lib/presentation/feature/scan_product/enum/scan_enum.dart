import '../../../../app/managers/const/icon_constant.dart';

enum ScanTypeEnum {
  image,
  product,
  invoice,
}

extension IconHomeEx on ScanTypeEnum {
  String get getIconSelect {
    switch (this) {
      case ScanTypeEnum.image:
        return IconConst.scanImageSelect;
      case ScanTypeEnum.product:
        return IconConst.scanProductSelect;
      case ScanTypeEnum.invoice:
        return IconConst.scanInvoiceSelect;
    }
  }

  String get getIconUnSelect {
    switch (this) {
      case ScanTypeEnum.image:
        return IconConst.scanUnImage;
      case ScanTypeEnum.product:
        return IconConst.scanProductUnSelect;
      case ScanTypeEnum.invoice:
        return IconConst.scanInvoiceUnSelect;
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
