import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:qrcode/common/bloc/event_bus/event_bus_state.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/history_scan/history_model.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

import '../../injector_container.dart';

class HistoryScanScreen extends StatefulWidget {
  const HistoryScanScreen({Key? key}) : super(key: key);

  @override
  HistoryScanScreenState createState() => HistoryScanScreenState();
}

class HistoryScanScreenState extends State<HistoryScanScreen> {
  List<HistoryModel> histories = [];
  bool isLoadding = false;
  Completer<void> _refreshCompleter = Completer();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  ///todo: remove later
  // Future _onRefresh() async {
  //   _initData();
  //   return _refreshCompleter.future;
  // }

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
            backgroundColor: const Color(0xFFF2F2F2),
            body: Column(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Lịch sử QR',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000)),
                  ),
                ),
                isLoadding
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : histories.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 320),
                            child: Text("Không có lịch sử nào!"),
                          )
                        :
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
                                const SizedBox(height: 16),
                                Text(
                                  '${histories.length} Sản phẩm',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (_, index) {
                                    return _item(histories[index]);
                                  },
                                  itemCount: histories.length,
                                ),
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
  //       Navigator.pushNamed(RouteName.DetailProductScreen,
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
  Widget _item(HistoryModel model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
                // productId: model.productId,
                ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: CustomImageNetwork(
              url: model.image,
              width: 74,
              height: 74,
              border: 5,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SizedBox(
                width: 164,
                child: Text(
                  model.productName ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                model.code ?? '',
                style: AppTextTheme.smallGrey,
              ),
              Text(
                model.numberSeri ?? '',
                style: AppTextTheme.smallGrey,
              ),
              const SizedBox(height: 12),
            ],
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              model.count ?? '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0085FF)),
            ),
          )
        ],
      ),
    );
  }

  // void _onScan() async {
  //   // final deviceId = await CommonUtil.getDeviceId();
  //   // LOG.w('_onScan: $deviceId');
  //   // final data = await Navigator.pushNamed(RouteName.ScanQrScreen);
  //   // LOG.w('_onScan: $data');
  //   // if (data != null) {
  //   //   injector<AppClient>().get(
  //   //       'scan-qr-code?device_id=${injector<AppCache>().deviceId}'
  //   //           '&city=ha noi&region=vn&url=$data');
  //   //   injector<AppCache>().cacheDataProduct = data;
  //   //   Navigator.pushNamed(RouteName.DetailProductScreen,
  //   //       arguments: ArgumentDetailProductScreen(
  //   //         url: data,
  //   //       ));
  //   // }
  //   Navigator.pushNamed(
  //     RouteName.NotiScreen,
  //   );
  // }
}
