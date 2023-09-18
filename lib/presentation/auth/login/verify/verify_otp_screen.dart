import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qrcode/app/di/injection.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';
import 'package:qrcode/presentation/auth/login/verify/bloc/verify_bloc.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

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
  AppUseCase appUseCase = getIt<AppUseCase>();

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
            BlocProvider(
              create: (context) => VerifyBloc(appUseCase, context),
              child: BlocBuilder<VerifyBloc, VerifyState>(
                  builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 128,
                      height: 45,
                      onTap: () {
                        context.read<VerifyBloc>().add(TapEvent(
                            widget.phone,
                            _formKey,
                            _controller.text,
                            _controller,
                            _focusNode));
                      },
                      text: 'Đăng nhập',
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
