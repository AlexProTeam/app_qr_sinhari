import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/presentation/auth/login/bloc/login_bloc.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import 'app/di/injection.dart';
import 'app/managers/color_manager.dart';
import 'app/route/navigation/route_names.dart';
import 'app/route/routes.dart';
import 'app/route/screen_utils.dart';
import 'firebase/firebase_config.dart';

dynamic decodeIsolate(String response) => jsonDecode(response);

dynamic endCodeIsolate(dynamic json) => jsonEncode(json);

dynamic parseJson(String text) => compute(decodeIsolate, text);

dynamic endCodeJson(dynamic json) => compute(endCodeIsolate, json);

Future main() async {
  await _beforeRunApp();
  runApp(const App());
}

Future<void> _beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await setupInjection();
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    ///todo:
    // FirebaseNotification.instance.initFirebaseNotification();
    // LocalNotification.instance
    //     .configureDidReceiveLocalNotificationSubject(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),

        ///todo: add this bloc to nested of login follow later
        BlocProvider(
          create: (context) => LoginBloc(),
        )
      ],
      child: MaterialApp(
        navigatorKey: Routes.instance.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'SinHair',
        onGenerateRoute: Routes.generateDefaultRoute,
        initialRoute: RouteDefine.splashScreen,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: AppColors.white,
        ),
        builder: (context, widget) {
          GScreenUtil.init(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: widget ?? const SizedBox());
        },
      ),
    );
  }
}
