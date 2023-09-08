import 'package:flutter/material.dart';

import '../../../feature/auth/splash/splash_screen.dart';

enum RouteDefine {
  loginScreen,
  homeScreen,
  listUserScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      //todo: change to same screen later
      RouteDefine.loginScreen.name: (_) => const SplashScreen(),
      RouteDefine.homeScreen.name: (_) => const SplashScreen(),
      RouteDefine.listUserScreen.name: (_) => const SplashScreen(),
    };

    final WidgetBuilder? routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (BuildContext context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
