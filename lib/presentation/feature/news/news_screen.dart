import 'package:flutter/material.dart';
import 'package:qrcode/common/network/client.dart';

import '../../../app/di/injection.dart';
import '../../../app/managers/color_manager.dart';
import '../../../app/managers/const/icon_constant.dart';
import '../../../app/managers/style_manager.dart';
import '../../../app/route/common_util.dart';
import '../../../app/route/navigation/route_names.dart';
import '../../../app/route/routes.dart';
import '../../widgets/custom_image_network.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'details_news/ui/detail_new_screen.dart';
import 'history_model.dart';

class NewsNested extends StatelessWidget {
  const NewsNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateBottomBarRoute,
      navigationKey: Routes.newsKey,
      initialRoute: BottomBarEnum.tinTuc.getRouteNames,
    );
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final List<NewsModelResponse> _histories = [];
  bool _isLoading = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Tin tức',
      ),
      backgroundColor: AppColors.bgrScafold,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                _histories.clear();
                _initData();
              },
              child: _histories.isEmpty
                  ? const Center(
                      child: Text("Không có tin tức nào!"),
                    )
                  : GridView.builder(
                      itemCount: _histories.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            2 /
                            (MediaQuery.of(context).size.height / 2.5),
                      ),
                      itemBuilder: (context, index) {
                        return _item(_histories[index]);
                      },
                    ),
            ),
    );
  }

  Widget _item(NewsModelResponse model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteDefine.detailNewScreen,
            arguments: ArgumentDetailNewScreen(
                newsDetail: model.id, url: model.image));
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
          const SizedBox(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Image.asset(
                      IconConst.miniClock,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      model.createdAt ?? '',
                      style: TextStyleManager.smallGrey,
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

  void _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final data =
          await getIt<AppClient>().post('list_news', handleResponse: false);
      data['data'].forEach((e) {
        _histories.add(NewsModelResponse.fromJson(e));
      });
      if (mounted) setState(() {});
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      _isLoading = false;
    });
  }
}
