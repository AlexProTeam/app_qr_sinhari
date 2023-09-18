import 'package:flutter/material.dart';

import '../../presentation/auth/change_pass/change_pass_screen.dart';
import '../../presentation/auth/forgot_pass/forgot_pass_screen.dart';
import '../../presentation/auth/login/login_screen.dart';
import '../../presentation/auth/login/verify_otp_screen.dart';
import '../../presentation/auth/register/register_screen.dart';
import '../../presentation/auth/splash/splash_screen.dart';
import '../../presentation/auth/welcome/welcome_screen.dart';
import '../../presentation/feature/bottom_bar_screen/bottom_bar_screen.dart';
import '../../presentation/feature/detail_product/detail_product_contact.dart';
import '../../presentation/feature/detail_product/detail_product_screen.dart';
import '../../presentation/feature/detail_product/product_active/ui/detail_product_active.dart';
import '../../presentation/feature/history_scan/ui/history_scan_screen.dart';
import '../../presentation/feature/home/home_screen.dart';
import '../../presentation/feature/list_product/list_product_screen.dart';
import '../../presentation/feature/news/details_news/ui/detail_new_screen.dart';
import '../../presentation/feature/news/news_screen/ui/news_screen.dart';
import '../../presentation/feature/notification/notification_screen.dart';
import '../../presentation/feature/personal/contact/contact_screen.dart';
import '../../presentation/feature/personal/personal_screen.dart';
import '../../presentation/feature/personal/terms/ui/terms_screen.dart';
import '../../presentation/feature/profile/ui/profile_screen.dart';
import '../../presentation/feature/scan/check_bill_screen.dart';
import '../../presentation/feature/scan_product/scan_qr.dart';
import '../../presentation/feature/webview/webview_detail_screen.dart';
import 'navigation/route_names.dart';
import 'navigation/slide_left_route.dart';

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
      case RouteDefine.splashScreen:
        return SlideLeftRoute(
          widget: const SplashScreen(),
        );
      case RouteDefine.welcomeScreen:
        return SlideLeftRoute(
          widget: welcomeScreenRoute,
        );
      case RouteDefine.bottomBarScreen:
        return SlideLeftRoute(
          widget: const BottomBarScreen(),
        );
      default:
        return _emptyRoute(settings);
    }
  }

  static Route<dynamic> generateBottomBarRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteDefine.policyScreen:
        return SlideLeftRoute(
          widget: PolicyScreen(
              arg: settings.arguments != null
                  ? settings.arguments as String
                  : null),
        );
      case RouteDefine.muaHangScrene:
        return SlideLeftRoute(
          widget: DetailProductContact(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentContactScreen
                : null,
          ),
        );
      case RouteDefine.activeScrene:
        return SlideLeftRoute(
          widget: DetailProductActive(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentActiveScreen
                : null,
          ),
        );
      case RouteDefine.notiScreen:
        return SlideLeftRoute(
          widget: const NotiScreen(),
        );

      case RouteDefine.verifyOtpScreen:
        return SlideLeftRoute(
          widget: VerifyOtpScreen(
            phone:
                settings.arguments != null ? settings.arguments as String : '',
          ),
        );
      case RouteDefine.historyScanScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const HistoryScanScreen(),
        );
      case RouteDefine.scanQrScreen:
        return SlideLeftRoute(
          widget: const ScanQrScreen(),
        );
      case RouteDefine.webViewScreen:
        return SlideLeftRoute(
          widget: const WebViewScreen(),
        );
      case RouteDefine.webViewDetailScreen:
        return SlideLeftRoute(
          widget: WebViewDetailScreen(
            url: settings.arguments != null ? settings.arguments as String : '',
          ),
        );
      case RouteDefine.profileScreen:
        return SlideLeftRoute(
          widget: getProfileScreenRoute,
        );
      case RouteDefine.personalScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const PersonalScreen(),
        );
      case RouteDefine.detailProductScreen:
        return SlideLeftRoute(
          widget: DetailProductScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentDetailProductScreen
                : null,
          ),
        );

      ///
      case RouteDefine.detailNewScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: DetailNewScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentDetailNewScreen
                : ArgumentDetailNewScreen(),
          ),
        );
      case RouteDefine.listProductScreen:
        return SlideLeftRoute(
          widget: ListProductScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentListProductScreen
                : ArgumentListProductScreen(),
          ),
        );
      case RouteDefine.homeScreen:
        return SlideLeftRoute(
          duration: 0,
          widget: const HomeScreen(),
        );
      case RouteDefine.changePassScreen:
        return SlideLeftRoute(
          widget: const ChangePassScreen(),
        );
      case RouteDefine.registerScreen:
        return SlideLeftRoute(
          widget: const RegisterScreen(),
        );
      case RouteDefine.forgotPassScreen:
        return SlideLeftRoute(
          widget: const ForgotPassScreen(),
        );
      case RouteDefine.loginScreen:
        return SlideLeftRoute(
          widget: LoginScreen(
            haveBack:
                settings.arguments != null ? settings.arguments as bool : false,
          ),
        );
      case RouteDefine.checkBillScreen:
        return SlideLeftRoute(
          widget: const CheckBillScreen(),
        );
      case RouteDefine.newsScreen:
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