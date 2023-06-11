import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
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
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _enable = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _focusNode.requestFocus();
    _controller.addListener(() {
      if (_controller.text.length == 6) {
        _enable = true;
      } else {
        _enable = false;
      }
      setState(() {});
    });
    super.initState();
  }

  void _onContinue() async {
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      injector<LoadingBloc>().add(StartLoading());
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
        Routes.instance.navigateAndRemove(RouteName.ContainerScreen);
      }
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      autoDismissKeyboard: true,
      customAppBar: CustomAppBar(
        title: 'Nhập mã OTP',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Nhập mã OTP",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Mã OTP sẽ được gửi đến SĐT của bạn",
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 85),
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
                  activeColor: AppColors.grey3,
                  inactiveFillColor: AppColors.grey3,
                  activeFillColor: AppColors.grey3,
                  selectedFillColor: AppColors.grey3,
                  inactiveColor: AppColors.grey3,
                  selectedColor: AppColors.grey3,
                ),
                keyboardType: TextInputType.number,
                enableActiveFill: true,
                onCompleted: (v) {},
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 12),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: _onContinue,
                  text: 'Đăng nhập',
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
