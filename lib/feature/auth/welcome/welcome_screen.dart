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

import '../../../common/const/icon_constant.dart';
import '../../widgets/custom_image_network.dart';

class WelcomeScreen extends StatefulWidget {
  final List<WelcomeModel> welcomeModel;

  const WelcomeScreen({Key? key, required this.welcomeModel}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  List<WelcomeModel> _welcomeModel = [];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    _welcomeModel = widget.welcomeModel;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.welcomeModel.isEmpty) {
        _initData().then((value) => setState(() {}));
      }
    });
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
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _welcomeModel.map((e) => _buildPageView(e.url)).toList(),
          ),
          SizedBox(
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
                  padding: const EdgeInsets.symmetric(horizontal: 22)
                      .copyWith(bottom: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Routes.instance
                            .navigateAndRemove(RouteName.bottomBarScreen),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.06)),
                          child: const Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _currentIndex != _welcomeModel.length - 1
                            ? {
                                setState(() => _currentIndex++),
                                _pageController.jumpToPage(_currentIndex)
                              }
                            : Routes.instance
                                .navigateAndRemove(RouteName.bottomBarScreen),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorEF4948,
                          ),
                          child: const Icon(
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
