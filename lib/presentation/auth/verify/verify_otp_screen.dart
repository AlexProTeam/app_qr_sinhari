part of app_layer;

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
  final AppUseCase _appUseCase = getIt<AppUseCase>();

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
      body: BlocProvider(
        create: (context) => VerifyBloc(
          _appUseCase,
        ),
        child: BlocConsumer<VerifyBloc, VerifyState>(
          listener: (context, state) {
            if (state.status == BlocStatusEnum.loading) {
              DialogManager.showLoadingDialog(context);
            }
            if (state.status == BlocStatusEnum.success) {
              DialogManager.hideLoadingDialog;
              SessionUtils.saveAccessToken(state.token);
              context.read<ProfileBloc>().add(InitProfileEvent());
              _focusNode.unfocus();
              Navigator.popUntil(context, (route) => route.isFirst);
              context.read<BottomBarBloc>().add(const ChangeTabBottomBarEvent(
                    bottomBarEnum: BottomBarEnum.home,
                    isRefresh: true,
                  ));
            }
            if (state.status == BlocStatusEnum.failed) {
              DialogManager.hideLoadingDialog;
              _controller.clear();
              ToastManager.showToast(
                context,
                text: state.mesErr,
              );
            }
          },
          builder: (context, state) {
            return Form(
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
                  BlocBuilder<VerifyBloc, VerifyState>(
                      builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          width: 128,
                          height: 45,
                          onTap: () {
                            /// todo: refactor logic to bloc

                            if (_controller.text.isEmpty) {
                              return ToastManager.showToast(
                                context,
                                text: 'bạn chưa nhập mã',
                                delaySecond: 1,
                              );
                            }
                            if (_controller.text.length < 6) {
                              return ToastManager.showToast(
                                context,
                                text: 'Chưa nhập đủ mã',
                                delaySecond: 1,
                              );
                            }

                            context.read<VerifyBloc>().add(
                                  TapEvent(
                                    widget.phone,
                                    _formKey,
                                    _controller.text,
                                    _controller,
                                    _focusNode,
                                  ),
                                );
                          },
                          text: 'Đăng nhập',
                        ),
                      ],
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
