import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/themes/theme_color.dart';

import '../bloc/bottom_bar_bloc.dart';
import '../enum/bottom_bar_enum.dart';

class BottomNavigation extends StatefulWidget {
  final Function(BottomBarEnum) onChange;

  const BottomNavigation({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  final double _heightItem = 66.64;

  @override
  void initState() {
    super.initState();
  }

  void changeToTab(BottomBarEnum enumData) {
    if (context.read<BottomBarBloc>().state.bottomBarEnum == enumData) {
      return;
    }
    widget.onChange(enumData);
    context
        .read<BottomBarBloc>()
        .add(ChangeTabBottomBarEvent(bottomBarEnum: enumData));
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
    final isSelected =
        dataEnum == context.read<BottomBarBloc>().state.bottomBarEnum;
    return GestureDetector(
      onTap: () => changeToTab(dataEnum),
      child: SizedBox(
        height: _heightItem,
        child: dataEnum == BottomBarEnum.scan
            ? const SizedBox.shrink()
            : Image.asset(
                dataEnum.getIcon,
                width: 19,
                color: isSelected ? AppColors.red2 : null,
              ),
      ),
    );
  }

  Widget get _centerIconWidget => Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: GScreenUtil.screenWidthDp / 5,
        height: _heightItem,
        child: InkWell(
          onTap: () => changeToTab(BottomBarEnum.scan),
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
