import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../feature/widgets/toast_manager.dart';
import '../../../app/managers/config_manager.dart';
import '../../../app/managers/constant_manager.dart';
import '../../../app/managers/status_code_manager.dart';
import '../../../app/utils/navigation_util.dart';
import '../../responses/object_response.dart';
import 'token_interceptor.dart';

class ErrorInterceptor extends Interceptor {
  @override
  // ignore: long-method
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final objectResponse = ObjectResponse.fromJson(
      err.response?.data,
      (json) => json,
    );
    if (StatusCodeManager.unAuthorize == err.response?.statusCode &&
        err.response?.data != null) {
      if (objectResponse.statusCode == StatusCodeManager.userPaused) {
        ///todo:  delete AccessToken
        // SessionUtils.deleteAccessToken;

        return;
      }

      if (objectResponse.statusCode == StatusCodeManager.loginMultiDevice) {
        _logout(objectResponse, err);

        return;
      }
    } else {
      handler.next(err);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: requestOptions.baseUrl,
        connectTimeout: AppConstant.connectionTimeOut,
        receiveTimeout: AppConstant.connectionTimeOut,
        contentType: Headers.jsonContentType,
      ),
    );

    final Interceptor logInterceptor = (kDebugMode ||
            ConfigManager.getInstance().appFlavor != FlavorManager.production)
        ? PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
          )
        : const Interceptor();

    dio.interceptors.addAll(
      [
        ErrorInterceptor(),
        TokenInterceptors(),
        logInterceptor,
      ],
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  void _logout(
    ObjectResponse<Object?> objectResponse,
    DioException err, {
    bool displayToast = true,
  }) async {
    ///todo: clear all data and pussh to home screen
    // SessionUtils.clear;
    // Navigator.pushNamedAndRemoveUntil(
    //   NavigationUtil.currentContext!,
    //   RouteDefine.startPageScreen.name,
    //   (Route<dynamic> route) => false,
    // );

    await Future.delayed(const Duration(milliseconds: 100));

    final message = (objectResponse.statusCode ?? 0)
        .toErrorMessage((objectResponse.message ?? err.message) ?? "Error");

    if (displayToast) {
      ToastManager.showToast(
        NavigationUtil.currentContext!,
        text: message,
        delaySecond: 3,
      );
    }
  }
}
