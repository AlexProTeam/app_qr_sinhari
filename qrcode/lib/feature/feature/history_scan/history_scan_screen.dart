import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/history_scan/history_model.dart';
import 'package:qrcode/feature/routes.dart';
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

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get(
          'history-scan-qr-code?device_id=${injector<AppCache>().deviceId}');
      data['data'][0].forEach((e) {
        histories.add(HistoryModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Lịch sử quét',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: histories.isNotEmpty
          ? ListView.builder(
              itemBuilder: (_, index) {
                return _item(histories[index]);
              },
              itemCount: histories.length,
            )
          : const SizedBox(),
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
}
