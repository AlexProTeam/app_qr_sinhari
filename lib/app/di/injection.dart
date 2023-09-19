import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/local/app_cache.dart';
import '../../../common/local/local_app.dart';
import '../../../common/network/client.dart';
import '../../data/app_all_api/api/app_api.dart';
import '../../data/app_all_api/repositories/app_repository_impl.dart';
import '../../data/utils/interceptor/token_interceptor.dart';
import '../../domain/login/repositories/app_repository.dart';
import '../../domain/login/usecases/app_usecase.dart';
import '../managers/config_manager.dart';
import '../managers/shared_pref_manager.dart';
import '../managers/theme_manager.dart';

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
  _initCommon();
  _registerRepository();
  _registerUseCase();
}

///todo: refactor
void _initCommon() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => AppClient(
        getIt(),
        getIt(),
      ));
  getIt.registerLazySingleton(() => LocalApp(getIt()));
}

Future _registerAppComponents() async {
  final SharedPreferencesManager? sharePreferences =
      await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharePreferences!);

  final appTheme = ThemeManager();
  getIt.registerLazySingleton(() => appTheme);
}

Future<void> _registerNetworkComponents() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: ConfigManager.getInstance().apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.addAll(
    [
      TokenInterceptors(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    ],
  );
  getIt.registerSingleton(dio);

  getIt.registerLazySingleton(
    (() => AppApi(dio, baseUrl: dio.options.baseUrl)),
  );
}

void _registerRepository() {
  getIt.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(getIt<AppApi>()),
  );

  getIt.registerLazySingleton(() => AppCache());
}

void _registerUseCase() {
  getIt.registerLazySingleton<AppUseCase>(
    () => AppUseCase(getIt<AppRepository>()),
  );
}
