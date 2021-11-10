import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/feature/auth/change_pass/change_pass_screen.dart';
import 'package:qrcode/feature/auth/forgot_pass/forgot_pass_screen.dart';
import 'package:qrcode/feature/auth/login/login_screen.dart';
import 'package:qrcode/feature/auth/register/register_screen.dart';
import 'package:qrcode/feature/auth/splash/splash_screen.dart';
import 'package:qrcode/feature/auth/verify_otp/verify_otp_screen.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/home/home_screen.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';
import 'package:qrcode/feature/feature/personal/personal_screen.dart';
import 'package:qrcode/feature/feature/profile/profile_screen.dart';
import 'package:qrcode/feature/injector_container.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndNavigateTo(
      {dynamic result, String? routeName, dynamic arguments}) {
    return navigatorKey.currentState!
        .popAndPushNamed(routeName ?? '', arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  dynamic popUntil() {
    return navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    injector<LoadingBloc>().add(FinishLoading());
    return navigatorKey.currentState!.pop(result);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    LOG.d('LOG ROUTE_NAVIGATOR: ${settings.name}');
    switch (settings.name) {
      case RouteName.ProfileScreen:
        return CupertinoPageRoute(
          builder: (context) => ProfileScreen(),
        );
      case RouteName.PersonalScreen:
        return CupertinoPageRoute(
          builder: (context) => PersonalScreen(),
        );
      case RouteName.DetailProductScreen:
        return CupertinoPageRoute(
          builder: (context) => DetailProductScreen(),
        );
      case RouteName.ListProductScreen:
        return CupertinoPageRoute(
          builder: (context) => ListProductScreen(),
        );
      case RouteName.HomeScreen:
        return CupertinoPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RouteName.ChangePassScreen:
        return CupertinoPageRoute(
          builder: (context) => ChangePassScreen(),
        );
      case RouteName.RegisterScreen:
        return CupertinoPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case RouteName.VerifyOtpScreen:
        return CupertinoPageRoute(
          builder: (context) => VerifyOtpScreen(),
        );
      case RouteName.ForgotPassScreen:
        return CupertinoPageRoute(
          builder: (context) => ForgotPassScreen(),
        );
      case RouteName.LoginScreen:
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RouteName.splashScreen:
        return CupertinoPageRoute(
          builder: (context) => SplashScreen(),
        );

      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
