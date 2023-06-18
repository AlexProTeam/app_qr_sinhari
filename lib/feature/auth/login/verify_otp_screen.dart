import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phone;

  const VerifyOtpScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  VerifyOtpScreenState createState() => VerifyOtpScreenState();
}

class VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _focusNode.requestFocus();
    _controller.addListener(() {
      if (_controller.text.length == 6) {
      } else {}
      setState(() {});
    });
    super.initState();
  }

  void _onContinue() async {
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      final data = await injector<AppClient>()
          .post('confirm-otp?phone=${widget.phone}&otp=${_controller.text}');
      String? accessToken = data['data']['result']['accessToken'];
      if (accessToken != null) {
        AppHeader appHeader = AppHeader();
        appHeader.accessToken = accessToken;
        injector<AppClient>().header = appHeader;
        injector<LocalApp>().saveStringSharePreference(
            KeySaveDataLocal.keySaveAccessToken, accessToken);
        final data = await injector<AppClient>().get('auth/showProfile');
        ProfileModel profileModel = ProfileModel.fromJson(data['data']);
        injector<AppCache>().profileModel = profileModel;
        Routes.instance.navigateAndRemove(RouteName.containerScreen);
      }
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      autoDismissKeyboard: true,
      backgroundColor: const Color(0xFFF2F2F2),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: Color(0xFFACACAC),
                    )),
                const SizedBox(width: 90),
                const Text(
                  'Nhập mã OTP',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Mã OTP sẽ được gửi đến SĐT của bạn",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                controller: _controller,
                autoDismissKeyboard: false,
                focusNode: _focusNode,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(4.0),
                  fieldHeight: 56.0,
                  fieldWidth: 52.0,
                  activeColor: AppColors.white,
                  inactiveFillColor: AppColors.white,
                  activeFillColor: AppColors.white,
                  selectedFillColor: AppColors.white,
                  inactiveColor: AppColors.white,
                  selectedColor: AppColors.white,
                ),
                keyboardType: TextInputType.number,
                enableActiveFill: true,
                onCompleted: (v) {},
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 128,
                  height: 45,
                  onTap: _onContinue,
                  text: 'Đăng nhập',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
