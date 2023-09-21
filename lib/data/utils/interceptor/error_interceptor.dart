// Project imports:
part of app_layer;

class ErrorInterceptor extends Interceptor {
  @override
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
      if (objectResponse.status == StatusCodeManager.userPaused) {
        SessionUtils.deleteAccessToken;
        return;
      }

      if (objectResponse.status == StatusCodeManager.loginMultiDevice) {
        _logout(objectResponse, err);

        return;
      }
    } else {
      handler.next(err);
    }
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

    final message = (objectResponse.status ?? 0)
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
