import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_state.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/history_scan/history_model.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_text.dart';

import '../../injector_container.dart';

class HistoryScanScreen extends StatefulWidget {
  const HistoryScanScreen({Key? key}) : super(key: key);

  @override
  _HistoryScanScreenState createState() => _HistoryScanScreenState();
}

class _HistoryScanScreenState extends State<HistoryScanScreen> {
  List<HistoryModel> histories = [];
  bool isLoadding = false;
  Completer<void> _refreshCompleter = Completer();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future _onRefresh() async {
    _initData();
    return _refreshCompleter.future;
  }

  void _initData() async {
    try {
      isLoadding = true;
      histories.clear();
      final data = await injector<AppClient>().get(
          'history-scan-qr-code?device_id=${injector<AppCache>().deviceId}');
      data['data'][0].forEach((e) {
        histories.add(HistoryModel.fromJson(e));
      });
      _refreshCompleter.complete();
      _refreshCompleter = Completer();
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      isLoadding = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventBusBloc, EventBusState>(
      bloc: injector<EventBusBloc>(),
      listener: (_, state) {
        if (state is EventBusReloadHistoryState) {
          _initData();
        }
      },
      child: SafeArea(
        child: Scaffold(
            // customAppBar: CustomAppBar(
            //   title: 'Lịch sử quét',
            //   haveIconLeft: false,
            // ),
            backgroundColor: Color(0xFFF2F2F2),
            body: Column(
              children: [
                SizedBox(height: 39),
                Center(
                  child: Text(
                    'Lịch sử QR',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000)),
                  ),
                ),
                // isLoadding
                //     ? Center(
                //         child: CircularProgressIndicator(),
                //       )
                //     : histories.isEmpty
                //         ? Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 320),
                //             child: Text("Không có lịch sử nào!"),
                //           )
                //         :
                // RefreshIndicator(
                //   onRefresh: _onRefresh,
                //   backgroundColor: Colors.white,
                //   color: AppColors.primaryColor,
                //   child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        '10 sản phẩm',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            return _item();
                          },
                          // itemCount: histories.length,
                          itemCount: 5),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // Widget _item(HistoryModel model) {
  //   return InkWell(
  //     onTap: () {
  //       Routes.instance.navigateTo(RouteName.DetailProductScreen,
  //           arguments: ArgumentDetailProductScreen(
  //             productId: model.productId,
  //           ));
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       child: Row(
  //         children: [
  //           CustomImageNetwork(
  //             url: model.image,
  //             width: 74,
  //             height: 74,
  //             border: 5,
  //           ),
  //           const SizedBox(width: 12),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(height: 12),
  //               Text(
  //                 model.productName ?? 'Dầu gội đầu nước hoa - Hương hoa sen',
  //                 style: AppTextTheme.mediumBlack,
  //               ),
  //               Text(
  //                 model.updatedAt ?? 'Mã Code: SIN-1073250',
  //                 style: AppTextTheme.smallGrey,
  //               ),
  //                 const SizedBox(height: 12),
  //               ],
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _item() {
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.DetailProductScreen,
            arguments: ArgumentDetailProductScreen(
                // productId: model.productId,
                ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.asset(
                IconConst.logo,
                width: 74,
                height: 74,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SizedBox(
                width: 164,
                child: Text(
                  'Dầu gội đầu nước hoa - Hương hoa sen',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Mã Code: SIN-1073250',
                style: AppTextTheme.smallGrey,
              ),
              Text(
                'Số Seri: L8O977V',
                style: AppTextTheme.smallGrey,
              ),
              const SizedBox(height: 12),
            ],
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '5 lần',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0085FF)),
            ),
          )
        ],
      ),
    );
  }

  void _onScan() async {
    // final deviceId = await CommonUtil.getDeviceId();
    // LOG.w('_onScan: $deviceId');
    // final data = await Routes.instance.navigateTo(RouteName.ScanQrScreen);
    // LOG.w('_onScan: $data');
    // if (data != null) {
    //   injector<AppClient>().get(
    //       'scan-qr-code?device_id=${injector<AppCache>().deviceId}'
    //           '&city=ha noi&region=vn&url=$data');
    //   injector<AppCache>().cacheDataProduct = data;
    //   Routes.instance.navigateTo(RouteName.DetailProductScreen,
    //       arguments: ArgumentDetailProductScreen(
    //         url: data,
    //       ));
    // }
    Routes.instance.navigateTo(
      RouteName.NotiScreen,
    );
  }
}
