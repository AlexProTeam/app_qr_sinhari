library app_layer;

import 'package:dio/dio.dart';
import 'package:qrcode/app/app.dart';

class TokenInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String accessToken = SessionUtils.accessToken;

    if (accessToken.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    // if (SessionUtils.refreshToken.isNotEmpty &&
    //     options.path.contains('refresh-token')) {
    //   options.headers["Authorization"] = "Bearer ${SessionUtils.refreshToken}";
    // }

    return super.onRequest(options, handler);
  }
}
