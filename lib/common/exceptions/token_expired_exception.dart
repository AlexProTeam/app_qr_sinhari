
import 'package:qrcode/common/exceptions/app_exception.dart';

class TokenExpiredException extends AppException {
  TokenExpiredException({int? errorCode, String? errorText})
      : super(
          message: 'Phiên đăng nhập đã hết hạn',
        );
}
