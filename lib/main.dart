import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/notification/local_notification.dart';
import 'package:qrcode/feature/injector_container.dart' as di;

import 'common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'common/bloc/snackbar_bloc/snackbar_state.dart';
import 'common/navigation/route_names.dart';
import 'common/notification/firebase_notification.dart';
import 'common/utils/screen_utils.dart';
import 'feature/injector_container.dart';
import 'feature/routes.dart';
import 'feature/themes/theme_color.dart';
import 'feature/widgets/loading_container.dart';

dynamic decodeIsolate(String response) => jsonDecode(response);

dynamic endCodeIsolate(dynamic json) => jsonEncode(json);

dynamic parseJson(String text) => compute(decodeIsolate, text);

dynamic endCodeJson(dynamic json) => compute(endCodeIsolate, json);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  LocalNotification.instance.setUp();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  List<BlocListener> _getBlocListener(context) => [
        BlocListener<SnackBarBloc, SnackBarState>(
            listener: _mapListenerSnackBarState),
      ];

  List<BlocProvider> _getProviders() => [
        BlocProvider<SnackBarBloc>(
          create: (_) => injector<SnackBarBloc>(),
        ),
      ];

  void _mapListenerSnackBarState(BuildContext context, SnackBarState state) {
    if (state is ShowSnackBarState) {
      Icon icon;
      Color color;
      String title;
      switch (state.type) {
        case SnackBarType.success:
          icon = const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          );
          color = const Color(0xff33B44A);
          title = "Success";
          break;
        case SnackBarType.warning:
          icon = const Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.orange;
          title = "Warning";
          break;
        default:
          icon = const Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = const Color(0xffF63E43);
          title = "Failed";
          break;
      }

      showFlash(
        context: Routes.instance.navigatorKey.currentContext!,
        duration: state.duration ?? const Duration(milliseconds: 3000),
        builder: (context, controller) {
          return FlashBar(
            controller: controller,
            backgroundColor: color,
            position: FlashPosition.top,
            margin: const EdgeInsets.all(8),
            forwardAnimationCurve: Curves.easeOutBack,
            reverseAnimationCurve: Curves.easeInCubic,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
            content: Text(
              state.mess!,
              style: const TextStyle(color: Colors.white),
            ),
            icon: icon,
            shouldIconPulse: true,
            showProgressIndicator: false,
          );
        },
      );
    }
  }

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
      providers: _getProviders(),
      child: MaterialApp(
        navigatorKey: Routes.instance.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Sinhair',
        onGenerateRoute: Routes.generateRoute,
        initialRoute: RouteName.splashScreen,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Montserrat',
          canvasColor: Colors.transparent,
          platform: TargetPlatform.iOS,
          bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff989898)),
        ),
        builder: (context, widget) {
          GScreenUtil.init(context);
          return LoadingContainer(
            child: MultiBlocListener(
              listeners: _getBlocListener(context),
              child: GestureDetector(
                child: widget ?? const SizedBox(),
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
          );
        },
      ),
    );
  }
}
