import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../injector_container.dart';
import 'noti_model.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  _NotiScreenState createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  List<NotiModel> histories = [];
  bool isLoadding = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      isLoadding = true;

      final data = await injector<AppClient>()
          .post('notifications', handleResponse: false);
      data['notifications'].forEach((e) {
        histories.add(NotiModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      isLoadding = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Thông báo',
      ),
      backgroundColor: AppColors.white,
      body: isLoadding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: histories.isEmpty
                      ? Center(
                          child: Text("Không có thông báo nào!"),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            return _item(histories[index]);
                          },
                          itemCount: histories.length,
                        ),
                ),
              ],
            ),
    );
  }

  Widget _item(NotiModel model) {
    return InkWell(
      onTap: () {
        // Routes.instance.navigateTo(RouteName.DetailProductScreen,
        //     arguments: ArgumentDetailProductScreen(
        //       productId: model.productId,
        //     ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        // decoration: BoxDecoration(
        //   boxShadow: StringConst.defaultShadow,
        //   borderRadius: BorderRadius.circular(12),
        //   color: Colors.white
        // ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  CustomImageNetwork(
                    url: model.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    border: 25,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title ?? '',
                        style: AppTextTheme.mediumBlack,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        model.des ?? '',
                        style: AppTextTheme.normalBlack,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        model.createdAt ?? '',
                        style: AppTextTheme.normalPrimary,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Divider(
              color: AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
