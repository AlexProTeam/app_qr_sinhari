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
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

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
      child: CustomScaffold(
          customAppBar: CustomAppBar(
            title: 'Lịch sử quét',
            haveIconLeft: false,
          ),
          backgroundColor: AppColors.white,
          body: isLoadding
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : histories.isEmpty
                  ? Center(
                      child: Text("Không có lịch sử nào!"),
                    )
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      backgroundColor: Colors.white,
                      color: AppColors.primaryColor,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (_, index) {
                                return _item(histories[index]);
                              },
                              itemCount: histories.length,
                            ),
                          ),
                        ],
                      ),
                    )),
    );
  }

  Widget _item(HistoryModel model) {
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.DetailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: model.productId,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            CustomImageNetwork(
              url: model.image,
              width: 70,
              height: 70,
              border: 8,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    model.productName ?? '',
                    style: AppTextTheme.mediumBlack,
                  ),
                  Text(
                    model.updatedAt ?? '',
                    style: AppTextTheme.smallGrey,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
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
