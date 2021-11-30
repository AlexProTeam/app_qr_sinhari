import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  const CustomTextField(
      {Key? key, this.controller, this.hintText, this.keyboardType,this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey5, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.done,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.only(bottom: 12, left: 16),
            hintStyle: AppTextTheme.smallGrey.copyWith(
              fontStyle: FontStyle.italic,
            )),
      ),
    );
  }
}
