import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/app/managers/color_manager.dart';

// ignore: must_be_immutable

class MBPTextField extends StatelessWidget {
  const MBPTextField(
      {Key? key,
      this.title,
      this.hint,
      this.errorText,
      this.subTitle,
      this.controller,
      required this.onChanged,
      this.keyboardType,
      this.autoFocus = false,
      this.hintColor,
      this.readOnly = false,
      this.backgroundColor,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.text,
      this.textStyle,
      this.textTitleStyle,
      this.maxLine = 1,
      this.errorMaxLines = 1,
      this.borderColor,
      this.isRequired = false,
      this.suffixTitle,
      this.crossTitle,
      this.textCapitalization,
      this.inputFormater,
      this.maxLenght,
      this.textInputAction,
      this.debounceTime,
      this.isDisable = false,
      this.onFieldSubmitted,
      this.focusNode,
      this.validator,
      this.autovalidateMode,
      this.isMarginLeft = true,
      this.enable})
      : super(key: key);

  final String? title;
  final String? hint;
  final String? errorText;
  final String? subTitle;
  final TextEditingController? controller;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final Color? hintColor;
  final bool readOnly;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onTap;
  final String? text;
  final TextStyle? textStyle;
  final TextStyle? textTitleStyle;
  final int? maxLine;
  final int? errorMaxLines;
  final Color? borderColor;
  final bool isRequired;
  final Widget? suffixTitle;
  final CrossAxisAlignment? crossTitle;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormater;
  final int? maxLenght;
  final TextInputAction? textInputAction;
  final int? debounceTime;
  final bool isDisable;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final bool? isMarginLeft;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    Timer? timer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: isMarginLeft == true ? 12 : 0),
                child: Row(
                  crossAxisAlignment: crossTitle ?? CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? '',
                      style: textTitleStyle ??
                          kTextMediumtStyle.copyWith(fontSize: 14),
                    ),
                    if (suffixTitle != null) suffixTitle!,
                    if (isRequired)
                      Text(
                        ' *',
                        style: kTextRegularStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: kTextCriticalColor),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        TextFormField(
          onChanged: (value) {
            timer?.cancel();
            timer = Timer(
              Duration(milliseconds: debounceTime ?? 500),
              () {
                onChanged(value);
              },
            );
          },
          textInputAction: textInputAction,
          inputFormatters: inputFormater ??
              (keyboardType == TextInputType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : []),
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          controller: controller,
          keyboardType: keyboardType,
          autofocus: autoFocus,
          readOnly: isDisable ? isDisable : readOnly,
          initialValue: text,
          maxLength: maxLenght,
          onFieldSubmitted: (value) {
            if (onFieldSubmitted != null) {
              onFieldSubmitted!(value);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          focusNode: focusNode,
          onEditingComplete: () {},
          style: textStyle ??
              kTextMediumtStyle.copyWith(
                fontSize: 14,
                color: AppColors.black,
              ),
          key: Key(text ?? ''),
          maxLines: maxLine,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hint ?? '',
              counterStyle: kTextMediumtStyle.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 12),
              hintStyle: kTextMediumtStyle.copyWith(
                  fontSize: 14, color: hintColor ?? kTextSubduedColor),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: borderColor ?? kTextSubduedColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: borderColor ?? kTextSubduedColor),
              ),
              filled: true,
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide:
                    BorderSide(color: borderColor ?? kSurfaceCriticalColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: borderColor ?? kTextSubduedColor),
              ),
              errorText: errorText == '' ? null : errorText,
              errorMaxLines: errorMaxLines,
              errorStyle: kTextRegularStyle.copyWith(
                  fontSize: 12, color: kSurfaceCriticalColor),
              fillColor: backgroundColor),
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: enable ?? true,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Text(
            subTitle ?? '',
            style: kTextRegularStyle.copyWith(
                fontSize: 12, color: kTextMediumColor),
          ),
        )
      ],
    );
  }
}
