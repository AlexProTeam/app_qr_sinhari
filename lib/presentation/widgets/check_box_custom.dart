import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';

class CheckBoxCustom extends StatelessWidget {
  const CheckBoxCustom({
    Key? key,
    this.title,
    this.onChanged,
    this.value,
    this.enable = true,
    this.isStart = true,
    this.titleStyle,
  }) : super(key: key);

  final String? title;
  final Function(bool?)? onChanged;
  final bool? value;
  final bool isStart;
  final bool enable;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isStart)
          Transform.scale(
            scale: 1.2,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Theme(
                data: ThemeData(unselectedWidgetColor: kBorderDividerColor),
                child: Checkbox(
                  checkColor: kThemeColorIcon,
                  activeColor: kIconPrimaryColor,
                  value: value ?? false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onChanged: (bool? value) {
                    onChanged!(value);
                  },
                ),
              ),
            ),
          ),
        if (isStart)
          const SizedBox(
            width: 8,
          ),
        Expanded(
          child: Text(
            title ?? '',
            style: titleStyle ?? kTextRegularStyle.copyWith(fontSize: 12),
          ),
        ),
        if (!isStart)
          Transform.scale(
            scale: 1.2,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Theme(
                data: ThemeData(unselectedWidgetColor: kBorderDividerColor),
                child: Checkbox(
                  checkColor: kThemeColorIcon,
                  activeColor: kIconPrimaryColor,
                  value: value ?? false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onChanged: (bool? value) {
                    if (enable) {
                      onChanged!(value);
                    }
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
