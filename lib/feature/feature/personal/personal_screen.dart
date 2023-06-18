import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  PersonalScreenState createState() => PersonalScreenState();
}

class PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // customAppBar: CustomAppBar(
      //   title: 'Tài khoản',
      //   haveIconLeft: false,
      // ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Tài khoản',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                injector<AppCache>().profileModel == null
                    ? CustomButton(
                        onTap: () {
                          Routes.instance.navigateTo(RouteName.loginScreen,
                              arguments: true);
                        },
                        text: 'Đăng nhập',
                        width: 128,
                        height: 45,
                      )
                    : Container(),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              width: 343,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(
                  8,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    injector<AppCache>().profileModel != null
                        ? _icon(
                            () {
                              Routes.instance
                                  .navigateTo(RouteName.profileScreen);
                            },
                            'Thông tin cá nhân',
                            IconConst.info,
                          )
                        : Container(),
                    _icon(
                      () {
                        Routes.instance.navigateTo(RouteName.webViewScreen,
                            arguments: 'https://sinhairvietnam.vn/lien-he/');
                      },
                      'Liên hệ',
                      IconConst.contact,
                    ),
                    _icon(
                      () {
                        Routes.instance.navigateTo(RouteName.profileScreen);
                        // Routes.instance.navigateTo(RouteName.GioiThieuScreen);
                      },
                      'Chính sách bán hàng',
                      IconConst.provisionOrder,
                    ),
                    _icon(
                      () {
                        // Routes.instance.navigateTo(RouteName.CheckBillScreen);
                        Routes.instance.navigateTo(RouteName.huongDanScreen);
                      },
                      'Chính sách bảo mật',
                      IconConst.provisionSecurity,
                    ),
                    _icon(
                      () {
                        Routes.instance.navigateTo(RouteName.verifyOtpScreen);
                      },
                      'Điều khoản sử dụng',
                      IconConst.adjust,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  width: 343,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(
                      8,
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Kết nối với Sinhair:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        _icon(() => {}, 'Gmail', IconConst.gmail),
                        _icon(() => {}, 'Facebook', IconConst.facebook),
                        _icon(() => {}, 'Zalo', IconConst.zalo),
                        _icon(() => {}, 'Apple', IconConst.apple),
                        const SizedBox(height: 17),
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                injector<AppCache>().profileModel != null
                    ? CustomButton(
                        onTap: () async {
                          injector<AppCache>().profileModel = null;
                          injector<AppCache>().havedLogin = false;
                          await injector<LocalApp>().saveStringSharePreference(
                              KeySaveDataLocal.keySaveAccessToken, '');
                          Routes.instance.navigateTo(RouteName.loginScreen,
                              arguments: false);
                        },
                        text: 'Đăng xuất',
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon(Function() onTap, String text, String iconData) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Center(
              child: Image.asset(
                iconData,
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 10),
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
