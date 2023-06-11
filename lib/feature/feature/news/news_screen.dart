import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/news/detail_new_screen.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/empty_widget.dart';

import '../../injector_container.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsModel> histories = [];
  bool isLoadding = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      isLoadding = true;
      final data =
          await injector<AppClient>().post('list_news', handleResponse: false);
      data['data'].forEach((e) {
        histories.add(NewsModel.fromJson(e));
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
        title: 'Tin tức',
        haveIconLeft: false,
      ),
      backgroundColor: AppColors.white,
      body: isLoadding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : histories.isEmpty
              ? Center(
                  child: Text("Không có tin tức nào!"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: histories.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (_, index) {
                                return _item(histories[index]);
                              },
                              itemCount: histories.length,
                            )
                          : EmptyWidget(
                              onReload: () {
                                _initData();
                              },
                            ),
                    ),
                  ],
                ),
    );
  }

  Widget _item(NewsModel model) {
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.DetailNewScreen,
            arguments: ArgumentDetailNewScreen(
                news_detail: model.id, url: model.image));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            boxShadow: StringConst.defaultShadow,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: model.image,
              width: double.infinity,
              height: 199,
              fit: BoxFit.cover,
              border: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? '',
                    style: AppTextTheme.mediumBlack,
                  ),
                  Text(
                    model.createdAt ?? '',
                    style: AppTextTheme.smallGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
