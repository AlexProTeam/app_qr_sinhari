import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool? texts;
  final double? height;

  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.texts,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey5, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextFormField(
        enabled: texts,
        controller: controller,
        textInputAction: TextInputAction.done,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.only(bottom: 12, left: 16),
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: AppColors.grey7,
            )),
      ),
    );
  }
}
