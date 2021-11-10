import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/exceptions/app_exception.dart';

class ServerException extends AppException {
  ServerException({
    String? message,
  }) : super(
          message: message ?? StringConst.someThingWentWrong,
        );
}
