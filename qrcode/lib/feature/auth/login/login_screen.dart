import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/auth/login/widgets/input_phone_widget.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

import '../../injector_container.dart';

class LoginScreen extends StatefulWidget {
  final bool? haveBack;

  const LoginScreen({Key? key, this.haveBack}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onContinue() async {
    if (!CommonUtil.validateAndSave(_formKey)) return;
    String text = _phoneController.text;
    String phoneNumber = text[0] != '0' ? '0$text' : text;
    try {
      injector<LoadingBloc>().add(StartLoading());
      await injector<AppClient>().post('auth-with-otp?phone=$phoneNumber');
      await injector<AppClient>().post('add_device', body: {
        'device_id': FirebaseNotification.instance.deviceToken,
      },handleResponse: false);
      Routes.instance
          .navigateTo(RouteName.VerifyOtpScreen, arguments: phoneNumber);
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      autoDismissKeyboard: true,
      resizeToAvoidBottomInset: false,
      customAppBar: CustomAppBar(
        title: 'Đăng nhập',
        iconLeftTap: () {
          if (widget.haveBack == false) {
            Routes.instance.navigateAndRemove(RouteName.splashScreen);
          } else {
            Routes.instance.pop();
          }
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 105),
                Text(
                  'Đăng nhập',
                  style: AppTextTheme.medium20PxBlack.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                TypePhoneNumber(
                  controller: _phoneController,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: _onContinue,
                      text: 'Tiếp Tục',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Spacer(),
                //     CustomGestureDetector(
                //       onTap: () {
                //         Routes.instance.navigateTo(RouteName.ForgotPassScreen);
                //       },
                //       child: Padding(
                //         padding:
                //             const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                //         child: Text(
                //           'Bạn quên mật khẩu ?',
                //           style: AppTextTheme.normalGrey,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // const Spacer(),
                // CustomGestureDetector(
                //   onTap: () {
                //     Routes.instance.navigateTo(RouteName.RegisterScreen);
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text.rich(TextSpan(children: [
                //           TextSpan(
                //               text: 'Bạn đã có tài khoản chưa? ',
                //               style: AppTextTheme.normalGrey),
                //           TextSpan(
                //               text: 'Đăng ký',
                //               style: AppTextTheme.normalPrimary.copyWith(
                //                 fontWeight: FontWeight.w700,
                //                 decoration: TextDecoration.underline,
                //               ))
                //         ]))
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
