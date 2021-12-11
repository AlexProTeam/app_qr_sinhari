import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

import '../../../injector_container.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: double.infinity,
      color: Colors.white,
      child: ListView(
        children: [
          const SizedBox(height: 16),
          injector<AppCache>().havedLogin == true
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () {
                        Routes.instance
                            .navigateAndRemove(RouteName.LoginScreen);
                      },
                      text: 'Đăng nhập',
                      width: 120,
                    ),
                  ],
                ),
          const SizedBox(height: 30),
          injector<AppCache>().havedLogin
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CustomImageNetwork(
                        url: injector<AppCache>().profileModel?.avatar,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${injector<AppCache>().profileModel?.name}',
                      style: AppTextTheme.normalBlack,
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        IconConst.logo,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
          CustomGestureDetector(
            onTap: () {
              Navigator.pop(context);
              Routes.instance.navigateTo(RouteName.ProfileScreen);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(
                      IconConst.person,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Text(
                    'Thông tin cá nhân',
                    style: AppTextTheme.normalBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomGestureDetector(
            onTap: () {
              Navigator.pop(context);
              Routes.instance.navigateTo(RouteName.HistoryScanScreen);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.history,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Lịch sử quét',
                    style: AppTextTheme.normalBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          injector<AppCache>().havedLogin == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () {
                        injector<LocalApp>().saveStringSharePreference(
                            KeySaveDataLocal.keySaveAccessToken, '');
                        Routes.instance
                            .navigateAndRemove(RouteName.LoginScreen);
                      },
                      text: 'Đăng xuất',
                      width: 120,
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
