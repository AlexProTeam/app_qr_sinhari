import 'package:flutter/material.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../app/route/validate_utils.dart';

class TypePhoneNumber extends StatelessWidget {
  final TextEditingController? controller;
  final double? height;

  const TypePhoneNumber({Key? key, this.controller, this.height})
      : super(key: key);

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
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16.0),
            hintText: 'Số điện thoại'),
        cursorColor: AppColors.grey8,
        style: TextStyleManager.normalGrey8.copyWith(fontSize: 14),
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
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.colorBorder,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(
            3,
          )),
        ),
        child: Center(child: child),
      );
}
