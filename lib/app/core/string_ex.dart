import 'package:qrcode/app/core/num_ex.dart';

extension StringNull on String? {
  String get toAppNumberFormatWithNull {
    RegExp regex = RegExp(r'[a-zA-Z]');

    if (!regex.hasMatch(this ?? '')) {
      return double.parse(this ?? '0').toAppNumberFormat;
    }

    return this ?? '';
  }
}
