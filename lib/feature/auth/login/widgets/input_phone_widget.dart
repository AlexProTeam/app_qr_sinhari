import 'package:flutter/material.dart';
import 'package:qrcode/common/utils/validate_utils.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

class TypePhoneNumber extends StatelessWidget {
  final TextEditingController? controller;

  const TypePhoneNumber({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _container(width: double.infinity, child: _textFieldPhone()))
      ],
    );
  }

  Widget _textFieldPhone() => TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16.0),
            hintText: 'Số điện thoại'),
        cursorColor: AppColors.grey8,
        style: AppTextTheme.normalGrey8.copyWith(fontSize: 20),
        validator: ValidateUtil.validPhone,
        autofocus: true,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        controller: controller,
      );

  Widget _container({
    required Widget child,
    double? width,
  }) =>
      Container(
        width: width,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.colorBorder,
          ),
          borderRadius: BorderRadius.all(Radius.circular(
            8,
          )),
        ),
        child: Center(child: child),
      );
}
