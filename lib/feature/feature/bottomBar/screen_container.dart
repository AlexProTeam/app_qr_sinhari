import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/feature/injector_container.dart';

import '../BottomBar/bottom_navigation.dart';
import 'enum/bottom_bar_enum.dart';

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({Key? key}) : super(key: key);

  @override
  ScreenContainerState createState() => ScreenContainerState();
}

class ScreenContainerState extends State<ScreenContainer> {
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
    final data = await injector<AppClient>().get('auth/showProfile');
    ProfileModel profileModel = ProfileModel.fromJson(data['data']);
    injector<AppCache>().profileModel = profileModel;
  }

  Future<void> _addToken() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://admin.sinhairvietnam.vn/api/add_device'));
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BottomNavigation(
            tabViews: BottomBarEnum.values.map((e) => e.getScreen).toList(),
          ),
        ),
      );
}
