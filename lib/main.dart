import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/common/notification/local_notification.dart';
import 'package:qrcode/feature/injector_container.dart' as di;

import 'common/navigation/route_names.dart';
import 'common/notification/firebase_notification.dart';
import 'common/utils/screen_utils.dart';
import 'feature/routes.dart';
import 'feature/themes/theme_color.dart';

dynamic decodeIsolate(String response) => jsonDecode(response);

dynamic endCodeIsolate(dynamic json) => jsonEncode(json);

dynamic parseJson(String text) => compute(decodeIsolate, text);

dynamic endCodeJson(dynamic json) => compute(endCodeIsolate, json);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  LocalNotification.instance.setUp();
  await Firebase.initializeApp();
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
    return MaterialApp(
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
        return Scaffold(
            resizeToAvoidBottomInset: false, body: widget ?? const SizedBox());
      },
    );
  }
}
