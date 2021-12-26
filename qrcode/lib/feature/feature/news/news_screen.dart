import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/history_scan/history_model.dart';
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

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().post(
          'list_news',handleResponse: false);
      data['data'].forEach((e) {
        histories.add(NewsModel.fromJson(e));
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
        title: 'Tin tức',
        haveIconLeft: false,
      ),
      backgroundColor: AppColors.white,
      body: Column(
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
              news_detail: model.id,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
          boxShadow: StringConst.defaultShadow,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
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
