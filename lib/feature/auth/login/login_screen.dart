import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/auth/login/widgets/input_phone_widget.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/dialog_manager_custom.dart';

import '../../injector_container.dart';
import '../../widgets/follow_keyboard_widget.dart';
import 'login_enum.dart';

class LoginScreen extends StatefulWidget {
  final bool? haveBack;

  const LoginScreen({Key? key, this.haveBack}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Đăng nhập', isShowBack: true),
      resizeToAvoidBottomInset: false,
      body: FollowKeyBoardWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconConst.logoLogin,
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
                        onTap: _onLogin,
                        text: 'Đăng nhập',
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Center(
                    child: Text(
                      'Hoặc',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      LoginEnum.values.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                            right:
                                index != LoginEnum.values.length - 1 ? 35 : 0),
                        child: LoginEnum.values[index].getIcon(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    if (!CommonUtil.validateAndSave(_formKey)) return;

    String text = _phoneController.text;
    String phoneNumber = text[0] != '0' ? '0$text' : text;

    _performLogin(phoneNumber);
  }

  Future<void> _performLogin(String phoneNumber) async {
    await DialogManager.showLoadingDialog(context);
    try {
      await injector<AppClient>().post('auth-with-otp?phone=$phoneNumber');
      await _addToken();
      if (mounted) {
        Navigator.pushNamed(
          context,
          RouteName.verifyOtpScreen,
          arguments: phoneNumber,
        );
      }
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    }
    DialogManager.hideLoadingDialog;
  }

  Future<void> _addToken() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://admin.sinhairvietnam.vn/api/add_device'));
    request.fields
        .addAll({'device_id': '${FirebaseNotification.instance.deviceToken}'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      log('Token added successfully: $responseBody');
    } else {
      log('Failed to add token: ${response.reasonPhrase}',
          error: response.reasonPhrase);
    }
  }
}
