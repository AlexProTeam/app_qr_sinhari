import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
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
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Column(
        children: [
          CustomGestureDetector(
            onTap: (){
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
            onTap: (){
              Routes.instance.navigateTo(RouteName.ChangePassScreen);
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
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          IconConst.password,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Đổi mật khẩu',
                    style: AppTextTheme.normalBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () {
                  Routes.instance.navigateAndRemove(RouteName.LoginScreen);
                },
                text: 'Đăng xuất',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
