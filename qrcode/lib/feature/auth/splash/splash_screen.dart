import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    // final showWelcome =
    //     injector<LocalApp>().getBool(KeySaveDataLocal.showWelcomeScreen);
    // if (showWelcome !=null) {
    //   await Future.delayed(Duration(milliseconds: 300));
    //   Routes.instance.navigateAndRemove(RouteName.WelcomeScreen);
    //   return;
    // }
    injector<AppCache>().deviceId = await CommonUtil.getDeviceId();
    String? _accessToken = injector<LocalApp>()
        .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
    if (_accessToken?.isEmpty ?? true) {
      await Future.delayed(Duration(seconds: 1));
      // Routes.instance.navigateTo(RouteName.ContainerScreen);
      Routes.instance.navigateAndRemove(RouteName.WelcomeScreen);
      return;
    }
    AppHeader appHeader = AppHeader();
    appHeader.accessToken = _accessToken;
    injector<AppClient>().header = appHeader;
    final data = await injector<AppClient>().get('auth/showProfile');
    ProfileModel profileModel = ProfileModel.fromJson(data['data']);
    injector<AppCache>().profileModel = profileModel;
    Routes.instance.navigateAndRemove(RouteName.WelcomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              IconConst.logo,
              width: MediaQuery.of(context).size.height*0.2,
              height: MediaQuery.of(context).size.height*0.2,
            ),
            const SizedBox(height: 12),
            Text(
              'Công ty TNHH Sinhair Japan',
              style: AppTextTheme.medium20PxBlack.copyWith(fontSize: 18),
            ),
            const Spacer(),
            Text(
              'Bản quyền thuộc sở hữu CÔNG TY TNHH SINHAIR Japan',
              style: AppTextTheme.normalGrey,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
