import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/presentation/feature/bottom_bar_screen/widget/bottom_navigation.dart';

import 'bloc/bottom_bar_bloc.dart';
import 'enum/bottom_bar_enum.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  BottomBarScreenState createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  final PageController _controller = PageController();
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    await _addToken();
  }

  Future<void> _addToken() async {
    _appUseCase.addDevice(SessionUtils.deviceId);
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => BottomBarBloc(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: BottomBarEnum.values
                  .map(
                    (e) => e.getScreen,
                  )
                  .toList(),
            ),
            BlocConsumer<BottomBarBloc, BottomBarState>(
              listenWhen: (previous, current) =>
                  previous.bottomBarEnum != current.bottomBarEnum,
              listener: (context, state) =>
                  _controller.jumpToPage(state.bottomBarEnum.index),
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return BottomNavigation(
                  onChange: (bottomBarEnum) {
                    _controller.jumpToPage(bottomBarEnum.index);
                  },
                );
              },
            )
          ],
        ),
      );
}
