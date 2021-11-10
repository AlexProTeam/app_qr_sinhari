import 'package:flutter/cupertino.dart';
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
import 'package:qrcode/feature/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      autoDismissKeyboard: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 34),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconConst.logo,
                  width: 117,
                  height: 117,
                ),
              ],
            ),
            const SizedBox(height: 85),
            Text(
              'Đăng nhập',
              style: AppTextTheme.medium20PxBlack.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Mật khẩu',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    Routes.instance.navigateAndRemove(RouteName.HomeScreen);
                  },
                  text: 'Đăng nhập',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                CustomGestureDetector(
                  onTap: () {
                    Routes.instance.navigateTo(RouteName.ForgotPassScreen);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                    child: Text(
                      'Bạn quên mật khẩu ?',
                      style: AppTextTheme.normalGrey,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            CustomGestureDetector(
              onTap: () {
                Routes.instance.navigateTo(RouteName.RegisterScreen);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Bạn đã có tài khoản chưa? ',
                          style: AppTextTheme.normalGrey),
                      TextSpan(
                          text: 'Đăng ký',
                          style: AppTextTheme.normalPrimary.copyWith(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ))
                    ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
