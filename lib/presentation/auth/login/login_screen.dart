import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qrcode/domain/login/usecases/app_usecase.dart';
import 'package:qrcode/presentation/auth/login/bloc/login_bloc.dart';
import 'package:qrcode/presentation/auth/login/widgets/input_phone_widget.dart';

import '../../../app/di/injection.dart';
import '../../../app/managers/const/icon_constant.dart';

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
                  BlocProvider(
                    create: (context) =>
                        LoginBloc(getIt<AppUseCase>(), context),
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            width: 128,
                            onTap: () {
                              context.read<LoginBloc>().add(
                                  TapEvent(_phoneController.text, _formKey));
                            },
                            text: 'Đăng nhập',
                          ),
                        ],
                      );
                    }),
                  ),

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
    );
  }
}
