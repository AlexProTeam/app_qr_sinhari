import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/feature/injector_container.dart';

import 'bloc/bottom_bar_bloc.dart';
import 'enum/bottom_bar_enum.dart';
import 'widget/bottom_navigation.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  BottomBarScreenState createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  final PageController _controller = PageController();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    String? accessToken = injector<LocalApp>()
        .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
    AppHeader appHeader = AppHeader();
    appHeader.accessToken = accessToken;
    injector<AppClient>().header = appHeader;
    await _addToken();
  }

  Future<void> _addToken() async {
    /// todo: change to base later.

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://beta.sinhairvietnam.vn/api/add_device'));
    request.fields
        .addAll({'device_id': '${FirebaseNotification.instance.deviceToken}'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      log('Token added successfully: $responseBody');
    } else {
      log('Failed to add token: ${response.reasonPhrase}',
          error: response.reasonPhrase);
    }
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
              buildWhen: (previous, current) =>
                  previous.bottomBarEnum != current.bottomBarEnum,
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
