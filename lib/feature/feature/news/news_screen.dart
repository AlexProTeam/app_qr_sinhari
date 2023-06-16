import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/news/detail_new_screen.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/empty_widget.dart';

import '../../../common/utils/screen_utils.dart';
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
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 50;
    return CustomScaffold(
      // customAppBar: CustomAppBar(
      //   title: 'Tin tức',
      //   haveIconLeft: false,
      // ),
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Tin tức',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          SizedBox(height: 17),
          isLoadding
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : histories.isEmpty
                  ? Center(
                      child: Text("Không có tin tức nào!"),
                    )
                  : Column(
                      children: [
                        histories.isNotEmpty
                            ?
                            //                   ListView.builder(
                            //                       shrinkWrap: true,
                            //                       physics: NeverScrollableScrollPhysics(),
                            //                       padding: EdgeInsets.zero,
                            //                       itemBuilder: (_, index) {
                            //                         return _item(histories[index]);
                            //                       },
                            //                       itemCount: histories.length,
                            //                     )
                            GridView.builder(
                                shrinkWrap: true,
                                itemCount: histories.length,
                                // controller: _scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 300 / 410,
                                ),
                                itemBuilder: (context, index) {
                                  return _item(histories[index]);
                                },
                              )
                            : EmptyWidget(
                                onReload: () {
                                  _initData();
                                },
                              ),
                      ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageNetwork(
            url: model.image,
            width: 164,
            height: 164,
            fit: BoxFit.cover,
            border: 12,
          ),
          SizedBox(
            height: 16.45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Image.asset(
                      IconConst.MiniClock,
                      width: 14,
                      height: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      model.createdAt ?? '',
                      style: AppTextTheme.smallGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
