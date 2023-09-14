import 'package:flutter/material.dart';
import 'package:qrcode/common/network/client.dart';

import '../../../app/di/injection.dart';
import '../../../app/managers/color_manager.dart';
import '../../../app/managers/style_manager.dart';
import '../../../app/route/common_util.dart';
import '../../widgets/custom_image_network.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/dialog_manager_custom.dart';
import 'noti_model.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  NotiScreenState createState() => NotiScreenState();
}

class NotiScreenState extends State<NotiScreen> {
  List<NotiModel> histories = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        await DialogManager.showLoadingDialog(context);
      }

      final data =
          await getIt<AppClient>().post('notifications', handleResponse: false);
      data['notifications'].forEach((e) {
        histories.add(NotiModel.fromJson(e));
      });
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {});
    DialogManager.hideLoadingDialog;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thông báo',
        isShowBack: true,
      ),
      backgroundColor: AppColors.bgrScafold,
      body: histories.isEmpty
          ? const Center(
              child: Text("Không có thông báo nào!"),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (_, index) => _item(histories[index]),
              itemCount: histories.length,
            ),
    );
  }

  Widget _item(NotiModel model) => Container(
        decoration: const BoxDecoration(
          color: AppColors.colorF4F5FB,
          border: Border(
            bottom: BorderSide(color: AppColors.grey4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageNetwork(
                url: model.image,
                width: 16,
                height: 16,
                fit: BoxFit.cover,
                border: 4,
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          model.title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        model.createdAt ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: AppColors.colorACACAC),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    model.des ?? '',
                    style: TextStyleManager.normalBlack,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              )),
            ],
          ),
        ),
      );
}
