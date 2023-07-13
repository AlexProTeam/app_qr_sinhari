import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

import '../../../common/model/profile_model.dart';
import '../welcome/welcome_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final List<WelcomeModel> _welcomeModel = [];

  @override
  void initState() {
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
    _initData();
  }

  void _initData() async {
    injector<AppCache>().deviceId = await CommonUtil.getDeviceId();

    String? accessToken = injector<LocalApp>()
        .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);

    try {
      AppHeader appHeader = AppHeader();
      appHeader.accessToken = accessToken;
      injector<AppClient>().header = appHeader;

      final data = await injector<AppClient>().get('auth/showProfile');
      ProfileModel profileModel = ProfileModel.fromJson(data['data']);
      injector<AppCache>().profileModel = profileModel;
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }

    if (accessToken?.isEmpty == true) {
      Navigator.pushReplacementNamed(
        Routes.instance.navigatorKey.currentContext!,
        RouteName.welcomeScreen,
        arguments: _welcomeModel,
      );

      return;
    }

    Navigator.pushReplacementNamed(
      Routes.instance.navigatorKey.currentContext!,
      RouteName.bottomBarScreen,
      arguments: _welcomeModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AnimatedLogo(animation: animation),
              const SizedBox(height: 12),
              Text(
                'Công ty TNHH Sinhair Japan',
                style: AppTextTheme.medium20PxBlack.copyWith(fontSize: 18),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 1, end: 1);
  static final _sizeTween = Tween<double>(begin: 150, end: 200);

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
            child: Image.asset(IconConst.logoMain)),
      ),
    );
  }
}
