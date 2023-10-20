// Project imports:
part of app_layer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late ProfileBloc _profileBloc;
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  @override
  void initState() {
    _profileBloc = context.read<ProfileBloc>();

    _initData();
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  Future<void> _initData() async {
    if (SessionUtils.deviceId.isEmpty) {
      final fcmToken = await FirebaseConfig.getTokenFcm();
      SessionUtils.saveDeviceId(fcmToken ?? '');
      try {
        await _appUseCase.addDevice(fcmToken ?? '');
      } on ApiException catch (e) {
        ToastManager.showToast(
          Routes.instance.navigatorKey.currentContext!,
          text: e.message,
        );
      }
    }

    await Future.delayed(const Duration(seconds: 3));

    if (SessionUtils.accessToken.isEmpty) {
      Navigator.pushReplacementNamed(
        Routes.instance.navigatorKey.currentContext!,
        RouteDefine.welcomeScreen,
      );

      return;
    }

    _profileBloc.add(InitProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        switch (state.status) {
          case BlocStatusEnum.failed:
            SessionUtils.deleteAccessToken;
            Navigator.pushReplacementNamed(
              Routes.instance.navigatorKey.currentContext!,
              RouteDefine.welcomeScreen,
            );
            break;
          case BlocStatusEnum.success:
            Navigator.pushReplacementNamed(
              Routes.instance.navigatorKey.currentContext!,
              RouteDefine.bottomBarScreen,
            );
            break;
          default:
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: _AnimatedLogo(animation: animation),
          )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 1, end: 1);
  static final _sizeTween = Tween<double>(begin: 150, end: 300);

  const _AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
        child: Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: SizedBox(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        child: Assets.icons.logoLogin.image(),
      ),
    ));
  }
}
