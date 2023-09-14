import 'package:intl/intl.dart';

import 'common_util.dart';
import 'log_util.dart';

class FormatUtils {
  static double? formatMoneyFromStringTextField(String? input) {
    try {
      if (input?.isEmpty ?? true) return 0.0;
      return double.tryParse((input ?? '').replaceAll('.', ''));
    } catch (e) {
      return 0.0;
    }
  }

  static String formatSpaceToDisplay(double? input) {
    if (input == null) return '';
    if (input - input.toInt() == 0) {
      return '$input';
    }
    if (input > 10) {
      return '${input.round()}';
    }
    return '${input}0000'.substring(0, 3);
  }

  static String formatAvageStar(double? input) {
    if (input == null) return '';
    if (input - input.toInt() == 0) {
      return '$input.0';
    }
    return '${input}0000'.substring(0, 3);
  }

  static String? convertSecondToTextHourMinute(int? seconds) {
    if (seconds == null) {
      return null;
    }

    if (seconds < 60) {
      return '$seconds giây';
    }
    int hour = (seconds / 3600).round();
    int minute = ((seconds - hour * 3600) / 60).round();
    String textHour = hour != 0 ? '${hour}giờ' : '';
    String minuteText = minute != 0 ? '${minute}phút' : '';
    return '$textHour$minuteText';
  }

  static String formatCurrencyDoubleToString(int? currency,
      {bool haveUnit = true, bool aboutZero = false}) {
    try {
      if (currency == 0 && aboutZero) {
        return '0 ₫';
      }
      if (CommonUtil.isNull(currency)) return '';
      final output = NumberFormat.simpleCurrency(locale: 'vi').format(currency);
      return haveUnit ? output : output.trim().replaceAll('₫', '');
    } catch (e) {
      lOG.e('Exception: formatCurrencyDoubleToString: ${e.toString()}');
      return '$currency';
    }
  }

  static int formatTextPriceToDouble(String input) {
    final format = input.replaceAll('đ', '').replaceAll('.', '').trim();
    return int.parse(format);
  }

  static int formatNumberProductPostSell(String input) {
    try {
      int format = int.parse(input);
      if (format < 1) {
        return 1;
      }
      return format;
    } catch (e) {
      return 1;
    }
  }

  static bool checkNumber(String input) {
    try {
      int format = int.parse(input);
      if (format < 1) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static String formatDateTimeString(String input) {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateFormat dateFormatLast = DateFormat("HH:mm - dd/MM/yyyy");
      DateTime datetime = dateFormat.parse(input);
      return dateFormatLast.format(datetime);
    } catch (e) {
      return input;
    }
  }

  static String formatDateTimeBySource(DateTime input, {String? source}) {
    try {
      DateFormat dateFormatLast = DateFormat(source ?? "HH:mm - dd/MM/yyyy");
      return dateFormatLast.format(input);
    } catch (e) {
      return '$input';
    }
  }

  static DateTime convertServerDateTime(double miliseconds) {
    DateTime dateDefault = DateTime(2019, 1, 1);
    return DateTime.fromMillisecondsSinceEpoch(
        dateDefault.millisecondsSinceEpoch + miliseconds.toInt() * 1000);
  }

  static String formatTimeDisplay(int time) {
    int minute = 0;
    String minuteText = "";
    int second = 0;
    String secondText = "";

    minute = time ~/ 60;
    second = time % 60;
    if (minute < 10) {
      minuteText = "0$minute";
    } else {
      minuteText = "$minute";
    }

    if (second < 10) {
      secondText = "0$second";
    } else {
      secondText = "$second";
    }
    return "$minuteText:$secondText";
  }
}
