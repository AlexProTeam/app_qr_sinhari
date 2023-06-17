import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../injector_container.dart';
import 'noti_model.dart';
import 'package:timeago/timeago.dart' as timeago;

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
      // customAppBar: CustomAppBar(
      //   title: 'Thông báo',
      // ),
      backgroundColor: Color(0xFFF2F2F2),
      body: isLoadding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Color(0xFFACACAC),
                        )),
                    SizedBox(width: 90),
                    Text(
                      'Thông báo',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(height: 16.75),
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
    DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
    DateTime dateTime = dateFormat.parse(model.createdAt!);
    return InkWell(
      onTap: () {
        // Routes.instance.navigateTo(RouteName.DetailProductScreen,
        //     arguments: ArgumentDetailProductScreen(
        //       productId: model.productId,
        //     ));
      },
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFF4F5FB)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageNetwork(
                    url: model.image,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                    // border: 25,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title ?? '',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
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
                    ],
                  )),
                  Text(
                    timeago.format(
                      dateTime,
                      ),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      color: Color(0xFFACACAC)
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFFACACAC),
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
