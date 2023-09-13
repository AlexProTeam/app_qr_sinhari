import 'package:dio/dio.dart';

import '../../../../common/const/key_save_data_local.dart';
import '../../../../common/local/local_app.dart';
import '../../../app/di/injection.dart';

class TokenInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String accessToken = getIt<LocalApp>()
            .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken) ??
        '';

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
