import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Tài khoản',
        haveIconLeft: false,
        // iconLeftTap: () {
        //   Routes.instance.pop();
        // },
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              injector<AppCache>().profileModel == null
                  ?  CustomButton(
                onTap: () {
                  Routes.instance.navigateAndRemove(RouteName.LoginScreen,
                      arguments: true);
                },
                text: 'Đăng nhập',
                width: 140,
                height: 40,
              ):Container(),
            ],
          ),
          injector<AppCache>().profileModel != null?
          _icon(
            () {
              Routes.instance.navigateTo(RouteName.ProfileScreen);
            },
            'Thông tin cá nhân',
            Icons.person,
          ):Container(),
          _icon(
            () {
              Routes.instance.navigateTo(RouteName.WebViewScreen,
                  arguments:
                      'https://sinhairvietnam.vn/lien-he/');
            },
            'Liên hệ',
            Icons.call,
          ),
          _icon(
            () {
              Routes.instance.navigateTo(RouteName.GioiThieuScreen);
            },
            'Giới thiệu',
            Icons.info,
          ),
          _icon(
            () {
              Routes.instance.navigateTo(RouteName.HuongDanScreen);
            },
            'Hướng dẫn',
            Icons.integration_instructions_rounded,
          ),
          _icon(
            () {
              Routes.instance.navigateTo(RouteName.PolicyScreen);
            },
            'Điều khoản chính sách',
            Icons.policy,
          ),
          // CustomGestureDetector(
          //   onTap: () {
          //     Routes.instance.navigateTo(RouteName.ProfileScreen);
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 12),
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 16),
          //           child: Image.asset(
          //             IconConst.person,
          //             width: 40,
          //             height: 40,
          //           ),
          //         ),
          //         Text(
          //           'Thông tin cá nhân',
          //           style: AppTextTheme.normalBlack.copyWith(
          //             fontWeight: FontWeight.w500,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              injector<AppCache>().profileModel != null
                  ? CustomButton(
                onTap: () {
                  injector<LocalApp>().saveStringSharePreference(
                      KeySaveDataLocal.keySaveAccessToken, '');
                  Routes.instance
                      .navigateAndRemove(RouteName.LoginScreen);
                },
                text: 'Đăng xuất',
              )
                  : Container(),
            ],
          ),

        ],
      ),
    );
  }

  Widget _icon(Function onTap, String text, IconData iconData) {
    return CustomGestureDetector(
      onTap: onTap,
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
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    iconData,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              text,
              style: AppTextTheme.normalBlack.copyWith(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
