import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
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
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({Key? key}) : super(key: key);

  @override
  _ScreenContainerState createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {

  void _scanQr() async {
    final deviceId = await CommonUtil.getDeviceId();
    LOG.w('_onScan: $deviceId');
    final data = await Routes.instance.navigateTo(RouteName.ScanQrScreen);
    LOG.w('_onScan: $data');
    if (data != null) {
      injector<AppClient>()
          .get('scan-qr-code?device_id=${injector<AppCache>().deviceId}'
              '&city=ha noi&region=vn&url=$data');
      injector<AppCache>().cacheDataProduct = data;
      Routes.instance.navigateTo(RouteName.DetailProductScreen,
          arguments: ArgumentDetailProductScreen(
            url: data,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Positioned(
            bottom: 40,
            child: _centerIconWidget(),)
        ],
      ),
    );
  }

  Widget _centerIconWidget() {
    final screenWidget = GScreenUtil.screenWidthDp;
    return InkWell(
      onTap: _scanQr,
      child: Container(
        width: 60,
        // color: AppColors.primaryColor,
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            )),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Container(
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
            const SizedBox(height: 4),
            Text(
              'Scan QR',
              style: AppTextTheme.smallGrey.copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
