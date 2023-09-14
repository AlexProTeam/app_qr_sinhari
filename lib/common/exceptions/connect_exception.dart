import 'package:qrcode/common/exceptions/app_exception.dart';

import '../../app/managers/const/string_const.dart';

class ConnectException extends AppException {
  ConnectException({String? message})
      : super(
          message: message ?? StringConst.connectError,
        );
}
