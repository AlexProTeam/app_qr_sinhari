import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

enum BottomBarEnum {
  home,
  lich_su_quet,
  scan,
  tin_tuc,
  ca_nhan,
}

extension BottomBarEx on BottomBarEnum {
  String get getIcon {
    switch (this) {
      case BottomBarEnum.home:
        return IconConst.home;
      case BottomBarEnum.lich_su_quet:
        return IconConst.lich_su_quet;
      case BottomBarEnum.scan:
        return IconConst.lich_su_quet;
      case BottomBarEnum.tin_tuc:
        return IconConst.tin_tuc;
      case BottomBarEnum.ca_nhan:
        return IconConst.ca_nhan;
    }
  }

  String get getTitle {
    switch (this) {
      case BottomBarEnum.home:
        return 'Lịch sử quét';
      case BottomBarEnum.lich_su_quet:
        return 'Tin tức';
      case BottomBarEnum.tin_tuc:
        return 'Tài khoản';
      case BottomBarEnum.ca_nhan:
        return 'Trang chủ';
    }
    return '';
  }
}

class BottomNavigation extends StatefulWidget {
  final List<Widget> tabViews;
  final Color? activeColor;
  final Color? inActiveColor;

  BottomNavigation({
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
  final int _indexCenterIcon = 2;

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: widget.tabViews,
            ),
          ),
          Image.asset(
            IconConst.backGroupBottomBar,
            width: double.infinity,
            height: _heightItem,
            fit: BoxFit.cover,
          ),
          Row(
            children: List.generate(
              BottomBarEnum.values.length,
              (index) => _buildBottomBarItem(index),
            ),
          ),
          _centerIconWidget
        ],
      ),
    );
  }

  Widget _buildBottomBarItem(int index) {
    final isSelected = index == _selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => changeToTabIndex(index),
        child: Container(
          height: _heightItem,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                BottomBarEnum.values[index].getIcon,
                width: index == _indexCenterIcon ? 0 : 18,
                height: index == _indexCenterIcon
                    ? 0
                    : 19 & index == 3
                        ? 21
                        : 18,
                fit: BoxFit.cover,
                color: isSelected ? AppColors.red2 : widget.inActiveColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _centerIconWidget => Container(
        margin: EdgeInsets.only(bottom: 20),
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

  void _scanQr() async {
    await Routes.instance.navigateTo(RouteName.ScanQrScreen);
  }
}
