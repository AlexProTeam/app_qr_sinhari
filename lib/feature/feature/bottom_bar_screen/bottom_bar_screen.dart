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
import 'package:qrcode/feature/feature/bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'package:qrcode/feature/injector_container.dart';

import '../../../common/navigation/route_names.dart';
import '../../routes.dart';
import '../../widgets/nested_route_wrapper.dart';
import 'widget/bottom_navigation.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  BottomBarScreenState createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  String _routeName = RouteName.homeScreen;

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
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                NestedRouteWrapper(
                  onGenerateRoute: Routes.generateBottomBarRoute,
                  navigationKey: Routes.bottomBarNavigatorKey,
                  initialRoute: _routeName,
                  onChangeScreen: (routeName) {
                    _routeName = routeName;
                  },
                ),
                BottomNavigation(onChange: (bottomBarEnum) {
                  if (ModalRoute.of(
                              Routes.bottomBarNavigatorKey.currentContext!)
                          ?.settings
                          .name !=
                      bottomBarEnum.getRouteNames) {
                    Navigator.pushReplacementNamed(
                        Routes.bottomBarNavigatorKey.currentContext!,
                        bottomBarEnum.getRouteNames);
                  }
                })
              ],
            ),
          ),
        ),
      );
}
