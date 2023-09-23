// Project imports:
part of app_layer;

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
  _registerRepository();
  _registerUseCase();
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
      connectTimeout: AppConstant.connectionTimeOutApp,
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
}

void _registerUseCase() {
  getIt.registerLazySingleton<AppUseCase>(
    () => AppUseCase(getIt<AppRepository>()),
  );
}
