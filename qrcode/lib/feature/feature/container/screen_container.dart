import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_event.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/feature/container/bottom_navigation.dart';
import 'package:qrcode/feature/feature/container/layout_keep_align.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/history_scan/history_scan_screen.dart';
import 'package:qrcode/feature/feature/home/home_screen.dart';
import 'package:qrcode/feature/feature/news/news_screen.dart';
import 'package:qrcode/feature/feature/personal/personal_screen.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:http/http.dart' as http;

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({Key? key}) : super(key: key);

  @override
  _ScreenContainerState createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {

  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    String? _accessToken = injector<LocalApp>()
        .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
    AppHeader appHeader = AppHeader();
    appHeader.accessToken = _accessToken;
    injector<AppClient>().header = appHeader;
    await _addToken();
    final data = await injector<AppClient>().get('auth/showProfile');
    ProfileModel profileModel = ProfileModel.fromJson(data['data']);
    injector<AppCache>().profileModel = profileModel;
  }

  Future _addToken() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://admin.sinhairvietnam.vn/api/add_device'));
    request.fields
        .addAll({'device_id': '${FirebaseNotification.instance.deviceToken}'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BottomNavigation(
              tabViews: [
                LayoutContainWidgetKeepAlive(child: HomeScreen()),
                LayoutContainWidgetKeepAlive(child: HistoryScanScreen()),
                LayoutContainWidgetKeepAlive(child: NewsScreen()),
                LayoutContainWidgetKeepAlive(child: PersonalScreen()),
              ],
            ),
            // _centerIconWidget()
          ],
        ),
      ),
    );
  }
}
