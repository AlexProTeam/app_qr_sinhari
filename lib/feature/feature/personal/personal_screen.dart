import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';

import '../../widgets/custom_scaffold.dart';
import '../bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  PersonalScreenState createState() => PersonalScreenState();
}

class PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Tài khoản',
            haveIconLeft: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  injector<AppCache>().profileModel == null
                      ? CustomButton(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginScreen,
                                arguments: true);
                          },
                          text: 'Đăng nhập',
                          width: 128,
                          height: 45,
                        )
                      : Container(),
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
                                    Navigator.pushNamed(
                                        context, RouteName.profileScreen);
                                  },
                                  'Thông tin cá nhân',
                                  IconConst.info,
                                )
                              : Container(),
                          _icon(
                            () {
                              Navigator.pushNamed(
                                  context, RouteName.webViewScreen,
                                  arguments:
                                      'https://sinhairvietnam.vn/lien-he/');
                            },
                            'Liên hệ',
                            IconConst.contact,
                          ),
                          _icon(
                            () {
                              Navigator.pushNamed(
                                  context, RouteName.gioiThieuScreen);
                            },
                            'Chính sách bán hàng',
                            IconConst.provisionOrder,
                          ),
                          _icon(
                            () {
                              // Navigator.pushNamed(RouteName.CheckBillScreen);
                              Navigator.pushNamed(
                                  context, RouteName.huongDanScreen);
                            },
                            'Chính sách bảo mật',
                            IconConst.provisionSecurity,
                          ),
                          _icon(
                            () {
                              Navigator.pushNamed(
                                  context, RouteName.policyScreen);
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
                                await injector<LocalApp>()
                                    .saveStringSharePreference(
                                        KeySaveDataLocal.keySaveAccessToken,
                                        '');
                                if (mounted) {
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.homeScreen,
                                  );
                                  context.read<BottomBarBloc>().add(
                                      const ChangeTabBottomBarEvent(
                                          bottomBarEnum: BottomBarEnum.home));
                                }
                              },
                              text: 'Đăng xuất',
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
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
