import 'package:flutter/material.dart';

import '../../../app/managers/route_names.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  ForgotPassScreenState createState() => ForgotPassScreenState();
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Quên mật khẩu',
        iconLeftTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, RouteDefine.verifyOtpScreen);
                  },
                  text: 'Gửi đi',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
