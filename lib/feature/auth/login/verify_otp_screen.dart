import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/dialog_manager_custom.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

import '../../feature/bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import '../../feature/bottom_bar_screen/enum/bottom_bar_enum.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Nhập mã OTP',
        isShowBack: true,
      ),
      backgroundColor: AppColors.bgrScafold,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Mã OTP sẽ được gửi đến SĐT ${widget.phone} của bạn",
                style: const TextStyle(
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
                validator: (value) {
                  if ((value ?? '').isEmpty) return;
                  return null;
                },
                onChanged: (value) {},
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

  Future<void> _onContinue() async {
    if (!CommonUtil.validateAndSave(_formKey)) return;
    if (_controller.text.isEmpty) {
      return await ToastManager.showToast(
        context,
        text: 'bạn chưa nhập mã',
        delaySecond: 1,
      );
    }
    if (_controller.text.length < 6) {
      return await ToastManager.showToast(
        context,
        text: 'Chưa nhập đủ mã',
        delaySecond: 1,
      );
    }

    try {
      await DialogManager.showLoadingDialog(context);
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
        if (mounted) {
          _focusNode.unfocus();
          context.read<BottomBarBloc>().add(const ChangeTabBottomBarEvent(
                bottomBarEnum: BottomBarEnum.home,
                isRefresh: true,
              ));
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      }
    } catch (e) {
      if (mounted) {
        await ToastManager.showToast(
          context,
          text: 'Mã không đúng',
        );
      }
      _controller.clear();
    }
    DialogManager.hideLoadingDialog;
  }
}
