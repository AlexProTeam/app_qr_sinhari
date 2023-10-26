import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/auth/login/bloc/login_bloc.dart';
import 'package:qrcode/presentation/auth/login/widgets/input_phone_widget.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../app/managers/route_names.dart';
import '../../../app/managers/status_bloc.dart';
import '../../../app/utils/common_util.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/follow_keyboard_widget.dart';

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
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == BlocStatusEnum.loading) {
            DialogManager.showLoadingDialog(context);
          }
          if (state.status == BlocStatusEnum.success) {
            DialogManager.hideLoadingDialog;
            Navigator.pushNamed(
              context,
              RouteDefine.verifyOtpScreen,
              arguments: _phoneController.text,
            );
          }
          if (state.status == BlocStatusEnum.failed) {
            DialogManager.hideLoadingDialog;
            ToastManager.showToast(
              context,
              text: state.mesErr,
            );
          }
        },
        child: FollowKeyBoardWidget(
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
                        Assets.icons.logoLogin.image(
                          width: 232,
                          height: 232,
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    TypePhoneNumber(
                      height: 45,
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            width: 128,
                            onTap: () {
                              if (!CommonUtil.validateAndSave(_formKey)) {
                                return;
                              }

                              context.read<LoginBloc>().add(
                                  LoginWithOtpEvent(_phoneController.text));
                            },
                            text: 'Đăng nhập',
                          ),
                        ],
                      );
                    }),

                    ///todo: update login in next version
                    const SizedBox(height: 15),
                    // const Center(
                    //   child: Text(
                    //     'Hoặc',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 12,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 11),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //     LoginEnum.values.length,
                    //     (index) => Padding(
                    //       padding: EdgeInsets.only(
                    //           right:
                    //               index != LoginEnum.values.length - 1 ? 35 : 0),
                    //       child: LoginEnum.values[index].getIcon(),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
