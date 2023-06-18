import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

import 'enum/bottom_bar_enum.dart';

class BottomNavigation extends StatefulWidget {
  final List<Widget> tabViews;
  final Color? activeColor;
  final Color? inActiveColor;

  const BottomNavigation({
    Key? key,
    required this.tabViews,
    this.activeColor = AppColors.primaryColor,
    this.inActiveColor = AppColors.grey6,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  final double _heightItem = 66.64;
  int _selectedIndex = 0;
  final int _indexCenterIcon = BottomBarEnum.scan.index;

  @override
  void initState() {
    super.initState();
  }

  void changeToTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        IndexedStack(
          index: _selectedIndex,
          children: widget.tabViews,
        ),
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
            (index) => _buildBottomBarItem(index),
          ),
        ),
        _centerIconWidget
      ],
    );
  }

  Widget _buildBottomBarItem(int index) {
    final isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => changeToTabIndex(index),
      child: SizedBox(
        height: _heightItem,
        child: index == _indexCenterIcon
            ? const SizedBox.shrink()
            : Image.asset(
                BottomBarEnum.values[index].getIcon,
                width: 19,
                color: isSelected ? AppColors.red2 : widget.inActiveColor,
              ),
      ),
    );
  }

  Widget get _centerIconWidget => Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: GScreenUtil.screenWidthDp / 5,
        height: _heightItem,
        child: InkWell(
          onTap: _scanQr,
          child: Center(
            child: Image.asset(
              IconConst.iconScanHome,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  void _scanQr() async =>
      await Routes.instance.navigateTo(RouteName.scanQrScreen);
}
