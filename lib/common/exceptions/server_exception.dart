import 'package:qrcode/common/exceptions/app_exception.dart';

import '../../re_base/app/managers/const/string_const.dart';

class ServerException extends AppException {
  ServerException({
    String? message,
  }) : super(
          message: message ?? StringConst.someThingWentWrong,
        );
}
