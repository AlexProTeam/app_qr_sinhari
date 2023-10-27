import 'dart:async';
import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/presentation/feature/address/bloc/address_bloc.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import 'app/managers/color_manager.dart';
import 'app/managers/route_names.dart';
import 'app/utils/screen_utils.dart';
import 'firebase/firebase_config.dart';
import 'firebase/firebase_options.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      await _beforeRunApp();
      runApp(const App());
    },
    (error, stack) {
      if (!kDebugMode) {
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
    },
  );
}

Future<void> _beforeRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: 'Sinhair');
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => AddressBloc(),
        ),
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
          return ScreenUtilInit(builder: (context, child) {
            GScreenUtil.init(context);
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: widget ?? const SizedBox());
          });
        },
      ),
    );
  }
}
