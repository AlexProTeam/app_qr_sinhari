import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/auth/welcome/welcome_model.dart';
import 'package:qrcode/feature/auth/welcome/welcome_point_widget.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';

import '../../../common/const/icon_constant.dart';
import '../../widgets/custom_image_network.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<WelcomeModel> _welcomeModel = [];
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _initData().then((value) => setState(() {})));
  }

  Future<void> _initData() async {
    await injector<LocalApp>()
        .saveBool(KeySaveDataLocal.showWelcomeScreen, true);
    try {
      final data = await injector<AppClient>()
          .post('get_image_introduction', handleResponse: false);
      final banners = data['banners'] as List<dynamic>;
      _welcomeModel = banners.map((e) => WelcomeModel.fromJson(e)).toList();
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: '_initData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _welcomeModel.map((e) => _buildPageView(e.Url)).toList(),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PointWidget(
                  currentIndex: _currentIndex,
                  dotSize: _welcomeModel.length,
                ),
                const SizedBox(height: 65),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22).copyWith(bottom: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomGestureDetector(
                        onTap: () => Routes.instance
                            .navigateTo(RouteName.ContainerScreen),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            decoration: TextDecoration.underline,
                            height: 1.5,
                          ),
                        ),
                      ),
                      CustomGestureDetector(
                        onTap: () => _currentIndex == _welcomeModel.length - 1
                            ? {
                                setState(() => _currentIndex++),
                                _pageController.jumpToPage(_currentIndex)
                              }
                            : Routes.instance
                                .navigateTo(RouteName.ContainerScreen),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFEF4948),
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(String? url) {
    return url != null
        ? CustomImageNetwork(
            url: url,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          )
        : Image.asset(
            IconConst.welcome,
            width: double.maxFinite,
            height: double.infinity,
            fit: BoxFit.cover,
          );
  }
}
