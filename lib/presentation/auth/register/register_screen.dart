import 'package:flutter/material.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../app/managers/style_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Assets.icons.back.image(
                width: 24,
                height: 24,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.logo.image(
                width: 24,
                height: 24,
              )
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đăng ký',
                  style: TextStyleManager.medium20PxBlack.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  hintText: 'Email',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  hintText: 'Họ và tên',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  hintText: 'Địa chỉ',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  hintText: 'Địa chỉ',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  hintText: 'Mật khẩu',
                ),
                const SizedBox(height: 12),
                const CustomTextField(
                  hintText: 'Nhập lại mật khẩu',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () {},
                      text: 'Đăng ký',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
