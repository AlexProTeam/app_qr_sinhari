import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:qrcode/common/notification/local_notification.dart';
import 'package:qrcode/feature/injector_container.dart' as di;

import 'common/bloc/profile_bloc/profile_bloc.dart';
import 'common/navigation/route_names.dart';
import 'common/notification/firebase_notification.dart';
import 'common/utils/screen_utils.dart';
import 'feature/routes.dart';
import 'feature/themes/theme_color.dart';
import 'firebase_options.dart';

dynamic decodeIsolate(String response) => jsonDecode(response);

dynamic endCodeIsolate(dynamic json) => jsonEncode(json);

dynamic parseJson(String text) => compute(decodeIsolate, text);

dynamic endCodeJson(dynamic json) => compute(endCodeIsolate, json);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  LocalNotification.instance.setUp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,name: 'DEV');
  if (kIsWeb) {
    FacebookAuth.i.webInitialize(
      appId: "2444192092457900", // Replace with your app id
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
  }
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    FirebaseNotification.instance.initFirebaseNotification();
    LocalNotification.instance
        .configureDidReceiveLocalNotificationSubject(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(),
        )
      ],
      child: MaterialApp(
        navigatorKey: Routes.instance.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'SinHair',
        onGenerateRoute: Routes.generateDefaultRoute,
        initialRoute: RouteName.splashScreen,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: AppColors.white,
        ),
        builder: (context, widget) {
          GScreenUtil.init(context);
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProfileBloc(),
              )
            ],
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: widget ?? const SizedBox()),
          );
        },
      ),
    );
  }
}
