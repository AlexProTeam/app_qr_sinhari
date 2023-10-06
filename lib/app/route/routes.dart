// Project imports:
part of app_layer;

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
      case RouteDefine.cartScreen:
        return SlideLeftRoute(
          widget: const CartScreen(),
        );
      case RouteDefine.successScreen:
        return SlideLeftRoute(
          widget: const SuccessScreen(),
        );
      case RouteDefine.detailOrder:
        return SlideLeftRoute(
          widget: const DetailOderScreen(),
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
            policy: settings.arguments as PolicyEnum,
          ),
        );
      case RouteDefine.muaHangScrene:
        return SlideLeftRoute(
          widget: BlocProvider(
            create: (context) => ProductDetailBloc(),
            child: DetailProductContact(
              argument: settings.arguments != null
                  ? settings.arguments as ArgumentContactScreen
                  : null,
            ),
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
      case RouteDefine.informationCustomer:
        return SlideLeftRoute(
          widget: const InfomationCustomer(),
        );
      case RouteDefine.historyDetb:
        return SlideLeftRoute(
          widget: const HistoryDetbScreen(),
        );
      case RouteDefine.detailOrder:
        return SlideLeftRoute(
          widget: const DetailOderScreen(),
        );
      case RouteDefine.payDebt:
        return SlideLeftRoute(
          widget: const PayDebt(),
        );
      case RouteDefine.payDebtQrScreen:
        return SlideLeftRoute(
          widget: const PayDebtQrScreen(),
        );
      case RouteDefine.cartScreen:
        return SlideLeftRoute(
          widget: const CartScreen(),
        );
      case RouteDefine.successScreen:
        return SlideLeftRoute(
          widget: const SuccessScreen(),
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
          widget: BlocProvider(
            create: (context) => ProductDetailBloc(),
            child: DetailProductScreen(
              argument: settings.arguments != null
                  ? settings.arguments as ArgumentDetailProductScreen
                  : null,
            ),
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
