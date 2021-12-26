import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/navigation/slide_left_route.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/feature/auth/change_pass/change_pass_screen.dart';
import 'package:qrcode/feature/auth/forgot_pass/forgot_pass_screen.dart';
import 'package:qrcode/feature/auth/login/login_screen.dart';
import 'package:qrcode/feature/auth/login/verify_otp_screen.dart';
import 'package:qrcode/feature/auth/register/register_screen.dart';
import 'package:qrcode/feature/auth/splash/splash_screen.dart';
import 'package:qrcode/feature/auth/verify_otp/verify_otp_screen.dart';
import 'package:qrcode/feature/auth/welcome/welcome_screen.dart';
import 'package:qrcode/feature/feature/container/screen_container.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/history_scan/history_scan_screen.dart';
import 'package:qrcode/feature/feature/home/home_screen.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';
import 'package:qrcode/feature/feature/news/detail_new_screen.dart';
import 'package:qrcode/feature/feature/notification/notification_screen.dart';
import 'package:qrcode/feature/feature/personal/gioi_thieu.dart';
import 'package:qrcode/feature/feature/personal/huong_dan.dart';
import 'package:qrcode/feature/feature/personal/policy_screen.dart';
import 'package:qrcode/feature/feature/personal/personal_screen.dart';
import 'package:qrcode/feature/feature/profile/profile_screen.dart';
import 'package:qrcode/feature/feature/scan_qr.dart';
import 'package:qrcode/feature/feature/webview/webview_screen.dart';
import 'package:qrcode/feature/injector_container.dart';

import 'feature/detail_product/mua_hang_screen.dart';

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
      case RouteName.GioiThieuScreen:
        return SlideLeftRoute(
          widget: GioiThieuScreen(),
        );
      case RouteName.HuongDanScreen:
        return SlideLeftRoute(
          widget: HuongDanScreen(),
        );
      case RouteName.PolicyScreen:
        return SlideLeftRoute(
          widget: PolicyScreen(),
        );
      case RouteName.MuaHangScrene:
        return SlideLeftRoute(
          widget: MuaHangScrene(),
        );
      case RouteName.NotiScreen:
        return SlideLeftRoute(
          widget: NotiScreen(),
        );
      case RouteName.ContainerScreen:
        return SlideLeftRoute(
          widget: ScreenContainer(),
        );
      case RouteName.WelcomeScreen:
        return SlideLeftRoute(
          widget: WelcomeScreen(),
        );
      case RouteName.VerifyOtpScreen:
        return SlideLeftRoute(
          widget: VerifyOtpScreen(
            phone:
                settings.arguments != null ? settings.arguments as String : '',
          ),
        );
      case RouteName.HistoryScanScreen:
        return SlideLeftRoute(
          widget: HistoryScanScreen(),
        );
      case RouteName.ScanQrScreen:
        return SlideLeftRoute(
          widget: ScanQrScreen(),
        );
      case RouteName.WebViewScreen:
        return SlideLeftRoute(
          widget: WebViewScreen(
            url: settings.arguments != null ? settings.arguments as String : '',
          ),
        );
      case RouteName.ProfileScreen:
        return SlideLeftRoute(
          widget: ProfileScreen(),
        );
      case RouteName.PersonalScreen:
        return SlideLeftRoute(
          widget: PersonalScreen(),
        );
      case RouteName.DetailProductScreen:
        return SlideLeftRoute(
          widget: DetailProductScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentDetailProductScreen
                : null,
          ),
        );
        ///
      case RouteName.DetailNewScreen:
        return SlideLeftRoute(
          widget: DetailNewScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentDetailNewScreen
                : null,
          ),
        );
      case RouteName.ListProductScreen:
        return SlideLeftRoute(
          widget: ListProductScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentListProductScreen
                : null,
          ),
        );
      case RouteName.HomeScreen:
        return SlideLeftRoute(
          widget: HomeScreen(),
        );
      case RouteName.ChangePassScreen:
        return SlideLeftRoute(
          widget: ChangePassScreen(),
        );
      case RouteName.RegisterScreen:
        return SlideLeftRoute(
          widget: RegisterScreen(),
        );
      // case RouteName.VerifyOtpScreen:
      //   return CupertinoPageRoute(
      //     widget: VerifyOtpScreen(),
      //   );
      case RouteName.ForgotPassScreen:
        return SlideLeftRoute(
          widget: ForgotPassScreen(),
        );
      case RouteName.LoginScreen:
        return SlideLeftRoute(
          widget: LoginScreen(
            haveBack:
                settings.arguments != null ? settings.arguments as bool : null,
          ),
        );
      case RouteName.splashScreen:
        return SlideLeftRoute(
          widget: SplashScreen(),
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
