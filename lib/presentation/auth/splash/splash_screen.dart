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

  @override
  void initState() {
    super.initState();
    initializeAnimation();
    initializeData();
  }

  void initializeAnimation() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  Future<void> initializeData() async {
    try {
      await _initDevice();
      await Future.delayed(const Duration(seconds: 3));
      _checkProfile();
    } catch (e) {
      ToastManager.showToast(
        Routes.instance.navigatorKey.currentContext!,
        text: 'Initialization Error: $e',
      );
    }
  }

  Future<void> _initDevice() async {
    try {
      if (SessionUtils.deviceId.isEmpty) {
        final fcmToken = await FirebaseConfig.getTokenFcm();
        SessionUtils.saveDeviceId(fcmToken ?? '');

        await getIt<AppUseCase>().addDevice(fcmToken ?? '');
      }
    } catch (e) {
      ToastManager.showToast(
        Routes.instance.navigatorKey.currentContext!,
        text: 'Device Initialization Error: $e',
      );
    }
  }

  void _checkProfile() {
    try {
      if (SessionUtils.accessToken.isEmpty) {
        _navigateToWelcomeScreen();
      } else {
        context.read<ProfileBloc>().add(InitProfileEvent());
      }
    } catch (e) {
      ToastManager.showToast(
        Routes.instance.navigatorKey.currentContext!,
        text: 'Access Token Check Error: $e',
      );
    }
  }

  void _navigateToWelcomeScreen() {
    Navigator.pushReplacementNamed(
      context,
      RouteDefine.welcomeScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == BlocStatusEnum.failed) {
          SessionUtils.deleteAccessToken;
          _navigateToWelcomeScreen();
        }
        if (state.status == BlocStatusEnum.success) {
          Navigator.pushReplacementNamed(
            context,
            RouteDefine.bottomBarScreen,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: _AnimatedLogo(animation: animation),
        ),
      ),
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
  static final _sizeTween = Tween<double>(begin: 200.r, end: 300.r);

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
      ),
    );
  }
}
