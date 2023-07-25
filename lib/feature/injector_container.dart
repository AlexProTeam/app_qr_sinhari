import 'package:get_it/get_it.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/bloc/profile_bloc/profile_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  _initCommon();
  _initBloc();
}

void _initBloc() {
  injector.registerLazySingleton(() => EventBusBloc());
  injector.registerLazySingleton(() => AppCache());
  injector.registerLazySingleton(() => ProfileBloc());
}

void _initCommon() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => sharedPreferences);
  injector.registerLazySingleton(() => AppClient(
        injector(),
        injector(),
      ));
  injector.registerLazySingleton(() => LocalApp(injector()));
}
