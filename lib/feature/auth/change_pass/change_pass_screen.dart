import 'package:flutter/material.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  ChangePassScreenState createState() => ChangePassScreenState();
}

class ChangePassScreenState extends State<ChangePassScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Đổi mật khẩu',
        iconLeftTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            const CustomTextField(
              hintText: 'Mật khẩu cũ',
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'Mật khẩu mới',
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'Nhập lại mật khẩu mới',
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    Routes.instance.navigateAndRemove(RouteName.loginScreen);
                  },
                  text: 'Lưu lại',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
