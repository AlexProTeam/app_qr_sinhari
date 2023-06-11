import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/auth/welcome/welcome_3_point.dart';
import 'package:qrcode/feature/auth/welcome/welcome_model.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

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
    _initData();
    super.initState();
  }

  void _initData() async {
    injector<LocalApp>().saveBool(KeySaveDataLocal.showWelcomeScreen, true);
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>()
          .post('get_image_introduction', handleResponse: false);
      data['banners'].forEach((e) {
        _welcomeModel.add(WelcomeModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: '_initData');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
         // const SizedBox(height: 50),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _welcomeModel.isNotEmpty
                  ? _welcomeModel.map((e) => _pageView(e)).toList()
                  : [],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            width: double.infinity,
            child: Column(
              children: [
                Welcome3Point(
                  currentIndex: _currentIndex,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CustomGestureDetector(
                      onTap: () {
                        Routes.instance.navigateTo(RouteName.ContainerScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Bỏ qua',
                          style: AppTextTheme.mediumBlack.copyWith(
                            color: AppColors.grey7,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomGestureDetector(
                      onTap: () {
                        if (_currentIndex < 2) {
                          setState(() {
                            _currentIndex++;
                          });
                          _pageController.jumpToPage(_currentIndex);
                          return;
                        }
                        Routes.instance.navigateTo(RouteName.ContainerScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Tiếp theo',
                          style: AppTextTheme.mediumBlack.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageView(WelcomeModel welcomeModel) {
    return SizedBox(
      width: double.infinity,
      child: Container(
      //  padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: CustomImageNetwork(
                url: welcomeModel.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text("Công ty TNHH Sinhair Japan", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14
            ),maxLines: 2,),
            SizedBox(height: 10,),
            Text(welcomeModel.title ?? '', style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),maxLines: 2,),
          ],
        ),
      ),
    );
  }
}
