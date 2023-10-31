import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../app/app.dart';
import '../app/managers/route_names.dart';
import 'notification/notification_service.dart';

Future setupFirebase() async {
  listenFirebaseMessage();

  // await FirebaseConfig.requestPermission();
  // await FirebaseConfig.showNotificationForeground();
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseConfig.onBackgroundPressed();
  // await NotificationLocalService().createChanel();
  // await FirebaseConfig.getTokenFcm();
  await FirebaseConfig.requestPermission();
  await FirebaseConfig.showNotificationForeground();
  FirebaseConfig.onBackgroundPressed();
  await NotificationLocalService().createChanel();
}

void listenFirebaseMessage() {
  NotificationLocalService().initNotification();
  FirebaseConfig.getInitialMessage();
  FirebaseConfig.receiveFromBackgroundState();
  FirebaseConfig.onMessage();
}

class FirebaseConfig {
  static Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  static void onBackgroundPressed() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        ///TODO
      }
    });
  }

  static void receiveFromBackgroundState() {
    /// onMessageOpenedApp: A Stream which posts a RemoteMessage when
    /// the application is opened from a background state.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(
        Routes.instance.navigatorKey.currentContext!,
        RouteDefine.notiScreen,
      );
    });
  }

  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final RemoteNotification? notification = message.notification;
      if (notification != null && Platform.isAndroid) {
        unawaited(
          NotificationLocalService().showNotification(
            id: notification.hashCode,
            title: notification.title ?? '',
            body: notification.body ?? '',
            payload: '',
          ),
        );
      }

      ReceivePort port = ReceivePort();
      IsolateNameServer.registerPortWithName(
        port.sendPort,
        AppConstant.portBackgroundMessage,
      );
      port.listen((dynamic data) {
        ///todo: handle here
      });
    });
  }

  static Future<void> showNotificationForeground() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static Future<String?> getTokenFcm() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  static Future<void> deleteTokenFcm() async {
    await FirebaseMessaging.instance.deleteToken();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Routes.instance.navigatorKey.currentState?.pushNamed(RouteDefine.notiScreen);
  final SendPort? send =
      IsolateNameServer.lookupPortByName(AppConstant.portBackgroundMessage);
  send?.send(message.data);
}
