import '../../re_base/app/managers/const/string_const.dart';

class AppException implements Exception {
  String message;

  AppException({
    this.message = StringConst.someThingWentWrong,
  });
}

class ExceptionConstants {
  static String messageConnect = 'ExceptionConstants.messageConnect';
  static String someThingWentWrong = 'ExceptionConstants.somethingWentWrong';
}
