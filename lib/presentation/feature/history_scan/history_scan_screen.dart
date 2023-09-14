import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/presentation/feature/history_scan/widget/item_history_scan_widget.dart';

import '../../../app/di/injection.dart';
import '../../../app/route/common_util.dart';
import '../../../app/route/routes.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'history_model.dart';

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

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Lịch sử QR'),
      body: RefreshIndicator(
        onRefresh: () async {
          await _initData();
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : histories.isEmpty
                ? const Center(child: Text("Không có lịch sử nào!"))
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
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                            padding: const EdgeInsets.only(bottom: 100),
                            itemBuilder: (_, index) {
                              return itemHistoryScan(context, histories[index]);
                            },
                            itemCount: histories.length,
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        isLoading = true;
      });
      histories.clear();
      final data = await getIt<AppClient>()
          .get('history-scan-qr-code?device_id=${getIt<AppCache>().deviceId}');
      data['data'][0].forEach((e) {
        histories.add(HistoryModel.fromJson(e));
      });
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      isLoading = false;
    });
  }
}
