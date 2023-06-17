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
      // customAppBar: CustomAppBar(
      //   title: 'Tài khoản',
      //   haveIconLeft: false,
      // ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
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
                          Routes.instance
                              .navigateTo(RouteName.LoginScreen, arguments: true);
                        },
                        text: 'Đăng nhập',
                        width: 128,
                        height: 45,
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              width: 343,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(
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
                              Routes.instance.navigateTo(RouteName.ProfileScreen);
                            },
                            'Thông tin cá nhân',
                            IconConst.Info,
                          )
                        : Container(),
                    _icon(
                      () {
                        Routes.instance.navigateTo(RouteName.WebViewScreen,
                            arguments: 'https://sinhairvietnam.vn/lien-he/');
                      },
                      'Liên hệ',
                      IconConst.Contact,
                    ),
                    _icon(
                      () {
                        Routes.instance.navigateTo(RouteName.ProfileScreen);
                        // Routes.instance.navigateTo(RouteName.GioiThieuScreen);
                      },
                      'Chính sách bán hàng',
                      IconConst.ProvisionOrder,
                    ),
                    _icon(
                      () {
                        // Routes.instance.navigateTo(RouteName.CheckBillScreen);
                        Routes.instance.navigateTo(RouteName.HuongDanScreen);
                      },
                      'Chính sách bảo mật',
                      IconConst.ProvisionSecurity,
                    ),
                    _icon(
                      () {
                        Routes.instance.navigateTo(RouteName.VerifyOtpScreen);
                      },
                      'Điều khoản sử dụng',
                      IconConst.Adjust,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  width: 343,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(
                      8,
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Kết nối với Sinhair:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        _icon(() => {}, 'Gmail', IconConst.Gmail),
                        _icon(() => {}, 'Facebook', IconConst.Facebook),
                        _icon(() => {}, 'Zalo', IconConst.Zalo),
                        SizedBox(height: 17),
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
                          Routes.instance.navigateTo(RouteName.LoginScreen,
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

  Widget _icon(Function onTap, String text, String iconData) {
    return CustomGestureDetector(
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
            SizedBox(width: 10),
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
