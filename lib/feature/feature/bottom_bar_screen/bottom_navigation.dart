import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

import 'enum/bottom_bar_enum.dart';

class BottomNavigation extends StatefulWidget {
  ///todo: can remove later
  // final List<Widget> tabViews;
  final Function(BottomBarEnum) onChange;

  const BottomNavigation({
    Key? key,

    ///todo: can remove later
    // required this.tabViews,
    required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  final double _heightItem = 66.64;
  BottomBarEnum _selectedEnum = BottomBarEnum.home;

  @override
  void initState() {
    super.initState();
  }

  void changeToTab(BottomBarEnum enumData) {
    widget.onChange(enumData);
    setState(() {
      _selectedEnum = enumData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          IconConst.backGroupBottomBar,
          width: double.infinity,
          height: _heightItem,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            BottomBarEnum.values.length,
            (index) => _buildBottomBarItem(BottomBarEnum.values[index]),
          ),
        ),
        _centerIconWidget,
      ],
    );
  }

  Widget _buildBottomBarItem(BottomBarEnum dataEnum) {
    final isSelected = dataEnum == _selectedEnum;
    return GestureDetector(
      onTap: () => changeToTab(dataEnum),
      child: SizedBox(
        height: _heightItem,
        child: dataEnum == BottomBarEnum.scan
            ? const SizedBox.shrink()
            : Image.asset(
                dataEnum.getIcon,
                width: 19,
                color: isSelected ? AppColors.red2 : AppColors.grey6,
              ),
      ),
    );
  }

  Widget get _centerIconWidget => Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: GScreenUtil.screenWidthDp / 5,
        height: _heightItem,
        child: InkWell(
          onTap: () => widget.onChange(BottomBarEnum
              .scan), // Fix: Wrap the callback inside another function
          child: Center(
            child: Image.asset(
              IconConst.iconScanHome,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
