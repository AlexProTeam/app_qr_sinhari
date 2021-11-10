
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/exceptions/app_exception.dart';

class ConnectException extends AppException {
  ConnectException({String? message})
      : super(
          message: message ?? StringConst.connectError,
        );
}
