import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Thông tin cá nhân',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(56),
                  child: Image.asset(
                    IconConst.logo,
                    width: 112,
                    height: 112,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Họ và tên',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Só điện thoại',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Địa chỉ',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {},
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
