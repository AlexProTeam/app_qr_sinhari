import 'package:qrcode/common/utils/format_utils.dart';

class ValidateUtil {
  static const String textValidPrice =
      'Số điểm không hợp lệ hoặc không được để trống';

  static const String typePhoneNumber = 'Nhập số điện thoại';
  static const String inValidPhoneNumber =
      'Có vẻ như số điện thoại không hợp lệ';
  static const String inValidCurrency = 'Số điểm không hợp lệ';

  static String? validCurrency(String? name) {
    double? money = FormatUtils.formatMoneyFromStringTextField(name);
    if (money == 0 || money == null) {
      return textValidPrice;
    }
    //
    // if (name.length >= 4 && money % 1000 != 0) {
    //   return 'Vui lòng nhập mệnh giá tiền nhỏ nhất là phần nghìn';
    // }
    return null;
  }

  static String? validName(String? name) {
    if ((name?.length ?? 0) < 5) {
      return 'Tên quá ngắn';
    }
    if ((name?.length ?? 0) > 30) {
      return 'Tên quá dài';
    }
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(name!)) {
      List<String> subString = name.trim().split(' ');
      if ((subString.isNotEmpty) && subString.length >= 2) {
        for (final obj in subString) {
          if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(obj)) {
            return 'Tên chỉ được chứa chữ cái hoặc số';
          }
        }
        return null;
      }
      return 'Tên chỉ được chứa chữ cái hoặc số';
    }
    return null;
  }

  static String? validTitleRate(String? input) {
    if (input?.isEmpty ?? true) {
      return 'Hãy nhập tiêu đề đánh giá';
    }
    return null;
  }

  static String? validContentRate(String? input) {
    if (input?.isEmpty ?? true) {
      return 'Nội dung đánh giá không được bỏ trống';
    }
    return null;
  }

  static String? validEmpty(String? input) {
    if (input?.isEmpty ?? true) {
      return 'Mục này không được bỏ trống';
    }
    return null;
  }

  static String? validReason(String? input) {
    if ((input?.trim().length ?? 0) < 5) {
      return 'Lý do quá ngắn';
    }
    if (input?.isEmpty ?? true) {
      return 'Vui lòng nhập lý do';
    }
    return null;
  }

  static String? validAddress(String? name, {String? output}) {
    if (name?.isEmpty ?? true) {
      return output ?? 'Hãy chọn địa chỉ';
    }
    return null;
  }

  static String? validStatusProduct(String? input) {
    if (input?.isEmpty ?? true) {
      return 'Hãy chọn tình trạng hàng';
    }
    return null;
  }

  static String? validCategory(String? name) {
    if (name?.isEmpty ?? true) {
      return 'Hãy chọn danh mục cho sản phẩm';
    }
    return null;
  }

  static String? validPhone(String? phone, {bool aboutNumberPhoneTest = true}) {
    if ((phone?.isNotEmpty ?? false) && phone?[0] != '0') {
      phone = '0$phone';
    }
    const String patttern = r'(^(09|03|08|05|07)+([0-9]{8})\b$)';
    final RegExp regExp = RegExp(patttern);
    if (phone?.isEmpty ?? true) {
      return typePhoneNumber;
    } else if (!regExp.hasMatch(phone ?? '')) {
      return inValidPhoneNumber;
    }
    return null;
  }

  static String? validNameProduct(String? name) {
    if ((name?.length ?? 0) < 20) {
      return 'Tên sản phẩm tối thiểu phải chứa 20 kí tự';
    }
    if (name!.length > 100) {
      return 'Tên sản phẩm tối đa chỉ được 100 kí tự';
    }
    return null;
  }

  static String? validNumberProduct(String name) {
    if (name.isEmpty) {
      return 'Nhập số lượng sản phẩm';
    }
    return null;
  }

  static String? validDescriptionProduct(String? name) {
    if ((name?.length ?? 0) < 150) {
      return 'Ít nhất 150 kí tự.';
    }

    return null;
  }

  // ko dc phép nhập tiền lẻ
  static String? validCurrencyWithCheckPerThousand(String? name) {
    final money = FormatUtils.formatMoneyFromStringTextField(name);
    if (money == 0 || money == null) {
      return textValidPrice;
    }
    if (money < 1000.0) {
      return 'Số điểm không thể lẻ hơn 1000';
    }
    if (name!.length >= 4 && money % 1000 != 0) {
      return 'Vui lòng nhập số điểm nhỏ nhất là phần nghìn';
    }
    return null;
  }

  // ko dc phép nhập tiền lẻ
  static String? validCurrencyDonate(String? input) {
    final money = FormatUtils.formatMoneyFromStringTextField(input);
    if (money == 0 || money == null) {
      return textValidPrice;
    }
    if (money < 1000.0) {
      return 'Số điểm ủng hộ phải lớn hơn 1000đ';
    }

    return null;
  }

  // dc phép nhập tiền lẻ
  static String? validCurrencyPostSell(String name) {
    final money = FormatUtils.formatMoneyFromStringTextField(name);
    if (money == 0 || money == null) {
      return textValidPrice;
    }
    if (money < 0) {
      return 'Số điểm không thể nhỏ hơn 0';
    }
    return null;
  }

  static String? validEmail(String? input) {
    if (input?.isEmpty ?? true) {
      return 'Mục này không được bỏ trống';
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(input!)) {
      return null;
    }
    return 'Email không hợp lệ';
  }
}
