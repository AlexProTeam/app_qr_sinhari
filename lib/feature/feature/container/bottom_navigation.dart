import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

const heightItem = 58.0;

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
  int selectedIndex = 0;
  List<String> _icon = [
    IconConst.home,
    IconConst.lich_su_quet,
    IconConst.tin_tuc,
    IconConst.ca_nhan,
  ];

  @override
  void initState() {
    super.initState();
  }

  void changeToTabIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _icon.asMap().entries.map(
          (entry) {
        final index = entry.key;
        final source = entry.value;
        final isSelected = index == selectedIndex;
        return source != null
            ? Expanded(
          child: Material(
            color: AppColors.primaryColor,
            child: InkWell(
              highlightColor: AppColors.grey6,
              splashColor: AppColors.grey6,
              onTap: () {
                if (!isSelected) {
                  changeToTabIndex(index);
                }
              },
              child: Container(
                height: heightItem,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      '$source',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                      color: isSelected
                          ? AppColors.white
                          : widget.inActiveColor,
                    ),
                    Text(
                      _mapIndexToString(index),
                      style: isSelected
                          ? AppTextTheme.normalGrey.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                          fontSize: 12)
                          : AppTextTheme.smallGrey
                          .copyWith(color: AppColors.grey6),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
            : const Spacer();
      },
    ).toList();
    tabs.insert(
        2,
        Container(
          width: GScreenUtil.screenWidthDp / 5,
          height: heightItem,
          color: AppColors.primaryColor,
          child: _centerIconWidget(),
        ));
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: IndexedStack(
        index: selectedIndex,
        children: widget.tabViews,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppColors.primaryColor,
        child: Row(
          children: tabs,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
    );
  }

  String _mapIndexToString(int index) {
    switch (index) {
      case 1:
        return 'Lịch sử quét';
      case 2:
        return 'Tin tức';
      case 3:
        return 'Tài khoản';
      default:
        return 'Trang chủ';
    }
  }

  Widget _centerIconWidget() {
    return InkWell(
      onTap: _scanQr,
      child: Container(
        width: 60,
        // color: AppColors.primaryColor,
        height: 80,
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      IconConst.scan,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scanQr() async {
    // final deviceId = await CommonUtil.getDeviceId();
    // LOG.w('_onScan: $deviceId');
    await Routes.instance.navigateTo(RouteName.ScanQrScreen);

  }
}
