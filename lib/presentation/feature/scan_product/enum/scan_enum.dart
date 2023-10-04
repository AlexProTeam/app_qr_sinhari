import 'package:qrcode/gen/assets.gen.dart';

enum ScanTypeEnum {
  image,
  product,
  invoice,
}

extension IconHomeEx on ScanTypeEnum {
  String get getIconSelect {
    switch (this) {
      case ScanTypeEnum.image:
        return Assets.icons.scanImgSelect.path;
      case ScanTypeEnum.product:
        return Assets.icons.scanProduct.path;
      case ScanTypeEnum.invoice:
        return Assets.icons.scanBillSelect.path;
    }
  }

  String get getIconUnSelect {
    switch (this) {
      case ScanTypeEnum.image:
        return Assets.icons.scanImage.path;
      case ScanTypeEnum.product:
        return Assets.icons.scanProductUnselect.path;
      case ScanTypeEnum.invoice:
        return Assets.icons.scanInvoice.path;
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
