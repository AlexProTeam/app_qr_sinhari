import 'package:intl/intl.dart';

extension DoubleNotNullExt on double {
  String get toAppNumberFormat {
    var formatterDouble = NumberFormat("#,##0.00", "en_US");

    if (this == 0) {
      return '0';
    }

    if (toDouble() == toInt()) {
      return toInt().toAppNumberFormat;
    }

    return formatterDouble.format(this);
  }
}

extension IntExt on int {
  String get toAppNumberFormat {
    var formatterInt = NumberFormat("#,###", "en_US");

    if (this == 0) {
      return '0';
    }

    return formatterInt.format(this);
  }
}
