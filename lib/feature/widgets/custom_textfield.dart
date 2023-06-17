import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool? texts;
  final double? height;
  final double? border;
  final double? fontsize;
  final IconData? icon;

  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.texts,
      this.height,
      this.fontsize,
      this.icon,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border.all(color: AppColors.grey5, width: 1),
        borderRadius: BorderRadius.circular(border ?? 4),
      ),
      child: TextFormField(
        enabled: texts,
        style: TextStyle(
          fontSize: fontsize ?? 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: AppColors.grey7,
        ),
        controller: controller,
        textInputAction: TextInputAction.done,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 11),
            suffixIcon: icon != null
                ? Icon(
                    icon,
                    size: 18,
                    color: AppColors.grey5,
                  )
                : null,
            hintStyle: TextStyle(
              fontSize: fontsize ?? 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: AppColors.grey7,
            )),
      ),
    );
  }
}
