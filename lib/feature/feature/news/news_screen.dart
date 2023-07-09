import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/news/detail_new_screen.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../injector_container.dart';
import '../../routes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';

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
  final List<NewsModel> _histories = [];
  bool _isLoading = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      _isLoading = true;
      final data =
          await injector<AppClient>().post('list_news', handleResponse: false);
      data['data'].forEach((e) {
        _histories.add(NewsModel.fromJson(e));
      });
      if (mounted) setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgrScafold,
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Tin tức',
            haveIconLeft: false,
          ),
          const SizedBox(height: 17),
          _isLoading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : _histories.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text("Không có tin tức nào!"),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: _histories.length,
                      // controller: _scrollController,
                      physics: const NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
  }

  Widget _item(NewsModel model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.detailNewScreen,
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
