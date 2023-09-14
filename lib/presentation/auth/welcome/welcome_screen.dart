import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_model.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_point_widget.dart';
import 'package:qrcode/presentation/widgets/widget_loading.dart';

import '../../../app/di/injection.dart';
import '../../../app/managers/color_manager.dart';
import '../../../app/managers/const/icon_constant.dart';
import '../../../app/managers/const/status_bloc.dart';
import '../../../app/route/navigation/route_names.dart';
import '../../../app/route/routes.dart';
import '../../../domain/login/usecases/app_usecase.dart';
import '../../widgets/custom_image_network.dart';
import 'bloc/welcome_bloc.dart';

Widget get welcomeScreenRoute => BlocProvider(
      create: (context) =>
          WelcomeBloc(getIt<AppUseCase>())..add(const InitWelcomeEvent()),
      child: const WelcomeScreen(
        welcomeModel: [],
      ),
    );

class WelcomeScreen extends StatefulWidget {
  final List<WelcomeModel> welcomeModel;

  const WelcomeScreen({Key? key, required this.welcomeModel}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WelcomeBloc, WelcomeState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.status == BlocStatusEnum.loading) {
            return const WidgetLoading();
          }
          final listData = state.welcomeModel?.banners ?? [];

          return Stack(
            children: [
              IndexedStack(
                index: _currentIndex,
                children: listData.map((e) => _buildPageView(e.url)).toList(),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PointWidget(
                      currentIndex: _currentIndex,
                      dotSize: listData.length,
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
                                .navigateAndRemove(RouteDefine.bottomBarScreen),
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
                            onTap: () => _currentIndex != listData.length - 1
                                ? {
                                    setState(() => _currentIndex++),
                                  }
                                : Routes.instance.navigateAndRemove(
                                    RouteDefine.bottomBarScreen),
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
          );
        },
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
