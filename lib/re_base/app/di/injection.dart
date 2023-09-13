import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/bloc/event_bus/event_bus_bloc.dart';
import '../../../common/bloc/profile_bloc/profile_bloc.dart';
import '../../../common/local/app_cache.dart';
import '../../../common/local/local_app.dart';
import '../../../common/network/client.dart';
import '../../data/login/api/login_api.dart';
import '../../data/login/repositories/login_repository_impl.dart';
import '../../domain/login/repositories/login_repository.dart';
import '../managers/config_manager.dart';
import '../managers/shared_pref_manager.dart';
import '../managers/theme_manager.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  _initCommon();
  _initBloc();
}

void _initBloc() {
  getIt.registerLazySingleton(() => EventBusBloc());
  getIt.registerLazySingleton(() => AppCache());
  getIt.registerLazySingleton(() => ProfileBloc());
}

void _initCommon() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => AppClient(
        getIt(),
        getIt(),
      ));
  getIt.registerLazySingleton(() => LocalApp(getIt()));
}

///

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
  _registerRepository();
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
    (() => LoginApi(dio, baseUrl: '${dio.options.baseUrl}user/')),
  );
}

void _registerRepository() {
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<LoginApi>()),
  );
}
