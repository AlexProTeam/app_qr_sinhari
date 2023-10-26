import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/utils/screen_utils.dart';
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Assets.icons.backGroupBottomBar.image(
          width: double.infinity,
          height: _heightItem,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            BottomBarEnum.values.length,
            (index) => _buildBottomBarItem(BottomBarEnum.values[index]),
          ),
        ),
        _centerIconWidget(),
      ],
    );
  }

  final double _heightItem = 66.64;

  void changeToTab(BottomBarEnum enumData) {
    if (context.read<BottomBarBloc>().state.bottomBarEnum == enumData) {
      return;
    }
    widget.onChange(enumData);
    context
        .read<BottomBarBloc>()
        .add(ChangeTabBottomBarEvent(bottomBarEnum: enumData));
  }

  Widget _buildBottomBarItem(BottomBarEnum dataEnum) {
    final isSelected =
        dataEnum == context.read<BottomBarBloc>().state.bottomBarEnum;
    return InkWell(
      onTap: () => changeToTab(dataEnum),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5.3,
        height: _heightItem,
        child: dataEnum == BottomBarEnum.scan
            ? const SizedBox.shrink()
            : Center(
                child: Image.asset(
                  dataEnum.getIcon,
                  width: 19,
                  color: isSelected ? AppColors.red2 : null,
                ),
              ),
      ),
    );
  }

  Widget _centerIconWidget() => Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: GScreenUtil.screenWidthDp / 5,
        height: _heightItem,
        child: InkWell(
          onTap: () => changeToTab(BottomBarEnum.scan),
          child: Center(
            child: Assets.icons.iconScanHome.image(
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
