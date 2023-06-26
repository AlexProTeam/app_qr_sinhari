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
import '../../routes.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';

class ScanHistoryNested extends StatelessWidget {
  const ScanHistoryNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateBottomBarRoute,
      navigationKey: Routes.historyScanKey,
      initialRoute: BottomBarEnum.lichSuQuet.getRouteNames,
    );
  }
}

class HistoryScanScreen extends StatefulWidget {
  const HistoryScanScreen({Key? key}) : super(key: key);

  @override
  HistoryScanScreenState createState() => HistoryScanScreenState();
}

class HistoryScanScreenState extends State<HistoryScanScreen> {
  List<HistoryModel> histories = [];
  bool isLoading = false;
  Completer<void> _refreshCompleter = Completer();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      isLoading = true;
      histories.clear();
      final data = await injector<AppClient>().get(
          'history-scan-qr-code?device_id=${injector<AppCache>().deviceId}');
      data['data'][0].forEach((e) {
        histories.add(HistoryModel.fromJson(e));
      });
      _refreshCompleter.complete();
      _refreshCompleter = Completer();
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      isLoading = false;
    }
    setState(() {
      isLoading = false;
    });
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
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : histories.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 320),
                            child: Text("Không có lịch sử nào!"),
                          )
                        : Padding(
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
}
