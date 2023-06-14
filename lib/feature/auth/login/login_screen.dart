import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

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
      await _addToken();
      Routes.instance
          .navigateTo(RouteName.VerifyOtpScreen, arguments: phoneNumber);
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  Future _addToken() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://admin.sinhairvietnam.vn/api/add_device'));
    request.fields
        .addAll({'device_id': '${FirebaseNotification.instance.deviceToken}'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      autoDismissKeyboard: true,
      resizeToAvoidBottomInset: false,
      // customAppBar: CustomAppBar(
      //   title: 'Đăng nhập',
      //   iconLeftTap: () {
      //     if (widget.haveBack == false) {
      //       Routes.instance.navigateAndRemove(RouteName.splashScreen);
      //     } else {
      //       Routes.instance.pop();
      //     }
      //   },
      // ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: Color(0xFFACACAC),
                  )),
              SizedBox(width: 90),
              Text(
                'Đăng nhập',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IconConst.Logo,
                            width: 232,
                            height: 232,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TypePhoneNumber(
                        height: 45,
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            width: 128,
                            onTap: _onContinue,
                            text: 'Đăng nhập',
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Text(
                          'Hoặc',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            IconConst.Gmail,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 35),
                          Image.asset(
                            IconConst.Facebook,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 35),
                          Image.asset(
                            IconConst.Zalo,
                            width: 30,
                            height: 30,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
