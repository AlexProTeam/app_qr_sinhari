import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qrcode/common/notification/local_notification.dart';
import 'package:qrcode/common/utils/log_util.dart';

class FirebaseNotification {
  factory FirebaseNotification() => _instance;

  FirebaseNotification._();

  static final FirebaseNotification _instance = FirebaseNotification._();

  static FirebaseNotification get instance => _instance;

  String? deviceToken;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  RemoteMessage? _remoteMessage;
  List<String> idsNotiIos = <String>[];
  Map<String, dynamic>? currentMessage;

  void handleOnMessage(
    Map<String, dynamic>? message,
  ) async {
    if (Platform.isAndroid) {
      // String typeNoti = _getTypeNotification(message) ?? '';
      // LOG.d('typeNotiNe: $typeNoti');
      // await LocalNotification.instance.showNotification(
      //   title: message?['title'],
      //   body: message?['body'],
      //   type: typeNoti,
      // );
    } else {
      // mapTypeMessageToNavigateTo(message);
    }
    currentMessage = message;
  }

  void initFirebaseNotification() async {
    firebaseMessaging.getToken().then((value) {
      deviceToken = value;
    });
    if (Platform.isIOS) {
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        _remoteMessage = message;
      });
    }
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      mapTypeMessageToNavigateTo(message?.data ?? {});
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      lOG.d('onMessageNe: ${event.data}');
      handleOnMessage(event.data);
      RemoteNotification? notification = event.notification;
      String typeNoti = _getTypeNotification(event.data) ?? '';
      lOG.d('typeNotiNe: $typeNoti');
      await LocalNotification.instance.showNotification(
        title: notification?.title,
        body: notification?.body,
        type: typeNoti,
      );
      // if (Platform.isIOS) {
      //   if (idsNotiIos.contains(event.messageId)) {
      //     mapTypeMessageToNavigateTo(event.data);
      //   } else {
      //     if (event.messageId != null) {
      //       idsNotiIos.add(event.messageId ?? '');
      //     }
      //   }
      // }
    });
    if (Platform.isIOS) {
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        _remoteMessage = message;
      });
    }
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      mapTypeMessageToNavigateTo(message.data);
    });
  }

  void handleBackgroundMessage() {
    mapTypeMessageToNavigateTo(_remoteMessage?.data ?? {});
    _remoteMessage = null;
  }

  void mapTypeMessageToNavigateTo(Map<String, dynamic>? message) {
    if (message?.isEmpty ?? true) {
      return;
    }
  }

  String? _getTypeNotification(Map<String, dynamic>? message) {
    try {
      if (message == null) {
        return null;
      }
      var typeMessage = message['msgType'];
      return typeMessage;
    } catch (e) {
      lOG.e('_getTypeNotification');
      return null;
    }
  }
}
