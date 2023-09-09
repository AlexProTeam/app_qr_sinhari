import 'package:flutter/material.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/navigation/slide_left_route.dart';
import 'package:qrcode/feature/auth/change_pass/change_pass_screen.dart';
import 'package:qrcode/feature/auth/forgot_pass/forgot_pass_screen.dart';
import 'package:qrcode/feature/auth/login/login_screen.dart';
import 'package:qrcode/feature/auth/login/verify_otp_screen.dart';
import 'package:qrcode/feature/auth/register/register_screen.dart';
import 'package:qrcode/feature/auth/splash/splash_screen.dart';
import 'package:qrcode/feature/auth/welcome/welcome_model.dart';
import 'package:qrcode/feature/auth/welcome/welcome_screen.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/detail_product/product_active/ui/detail_product_active.dart';
import 'package:qrcode/feature/feature/history_scan/ui/history_scan_screen.dart';
import 'package:qrcode/feature/feature/home/home_screen.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';
import 'package:qrcode/feature/feature/news/details_news/ui/detail_new_screen.dart';
import 'package:qrcode/feature/feature/news/news_screen/ui/news_screen.dart';
import 'package:qrcode/feature/feature/notification/ui/notification_screen.dart';
import 'package:qrcode/feature/feature/personal/personal_screen.dart';
import 'package:qrcode/feature/feature/personal/terms/ui/terms_screen.dart';
import 'package:qrcode/feature/feature/profile/ui/profile_screen.dart';
import 'package:qrcode/feature/feature/scan/check_bill_screen.dart';
import 'package:qrcode/feature/feature/scan_product/scan_qr.dart';
import 'package:qrcode/feature/feature/webview/webview_detail_screen.dart';

import 'feature/bottom_bar_screen/bottom_bar_screen.dart';
import 'feature/detail_product/product_contact/ui/detail_product_contact.dart';
import 'feature/personal/contact/contact_screen.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> bottomBarNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> historyScanKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> scanKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> newsKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> personalKey =
      GlobalKey<NavigatorState>();

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

  static Route<dynamic> generateDefaultRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return SlideLeftRoute(
          widget: const SplashScreen(),
        );
      case RouteName.welcomeScreen:
        return SlideLeftRoute(
          widget: WelcomeScreen(
            welcomeModel: settings.arguments != null
                ? settings.arguments as List<WelcomeModel>
                : [],
          ),
        );
      case RouteName.bottomBarScreen:
        return SlideLeftRoute(
          widget: const BottomBarScreen(),
        );
      default:
        return _emptyRoute(settings);
    }
  }

  static Route<dynamic> generateBottomBarRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.policyScreen:
        return SlideLeftRoute(
          widget: PolicyScreen(
              arg: settings.arguments != null
                  ? settings.arguments as String
                  : null),
        );
      case RouteName.muaHangScrene:
        return SlideLeftRoute(
          widget: DetailProductContact(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentContactScreen
                : null,
          ),
        );
      case RouteName.activeScrene:
        return SlideLeftRoute(
          widget: DetailProductActive(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentActiveScreen
                : null,
          ),
        );
      case RouteName.notiScreen:
        return SlideLeftRoute(
          widget: const NotiScreen(),
        );

      case RouteName.verifyOtpScreen:
        return SlideLeftRoute(
          widget: VerifyOtpScreen(
            phone:
                settings.arguments != null ? settings.arguments as String : '',
          ),
        );
      case RouteName.historyScanScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const HistoryScanScreen(),
        );
      case RouteName.scanQrScreen:
        return SlideLeftRoute(
          widget: const ScanQrScreen(),
        );
      case RouteName.webViewScreen:
        return SlideLeftRoute(
          widget: const WebViewScreen(),
        );
      case RouteName.webViewDetailScreen:
        return SlideLeftRoute(
          widget: WebViewDetailScreen(
            url: settings.arguments != null ? settings.arguments as String : '',
          ),
        );
      case RouteName.profileScreen:
        return SlideLeftRoute(
          widget: getProfileScreenRoute,
        );
      case RouteName.personalScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const PersonalScreen(),
        );
      case RouteName.detailProductScreen:
        return SlideLeftRoute(
          widget: DetailProductScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentDetailProductScreen
                : null,
          ),
        );

      ///
      case RouteName.detailNewScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: DetailNewScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentDetailNewScreen
                : ArgumentDetailNewScreen(),
          ),
        );
      case RouteName.listProductScreen:
        return SlideLeftRoute(
          widget: ListProductScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentListProductScreen
                : ArgumentListProductScreen(),
          ),
        );
      case RouteName.homeScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const HomeScreen(),
        );
      case RouteName.changePassScreen:
        return SlideLeftRoute(
          widget: const ChangePassScreen(),
        );
      case RouteName.registerScreen:
        return SlideLeftRoute(
          widget: const RegisterScreen(),
        );
      case RouteName.forgotPassScreen:
        return SlideLeftRoute(
          widget: const ForgotPassScreen(),
        );
      case RouteName.loginScreen:
        return SlideLeftRoute(
          widget: LoginScreen(
            haveBack:
                settings.arguments != null ? settings.arguments as bool : false,
          ),
        );
      case RouteName.checkBillScreen:
        return SlideLeftRoute(
          widget: const CheckBillScreen(),
        );
      case RouteName.newsScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const NewsScreen(),
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
