import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/common/notification/local_notification.dart';
import 'package:qrcode/feature/app.dart';
import 'package:qrcode/feature/injector_container.dart' as di;
import 'package:qrcode/feature/themes/theme_color.dart';
import 'dart:async';


dynamic decodeIsolate(String response) => jsonDecode(response);

dynamic endCodeIsolate(dynamic json) => jsonEncode(json);

dynamic parseJson(String text) => compute(decodeIsolate, text);

dynamic endCodeJson(dynamic json) => compute(endCodeIsolate, json);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.black
  ));
  LocalNotification.instance.setUp();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}
