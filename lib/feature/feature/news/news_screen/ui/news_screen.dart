import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';
import 'package:qrcode/feature/feature/news/news_screen/bloc/news_bloc.dart';
import 'package:qrcode/feature/feature/news/news_screen/widget/item_news.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../../../routes.dart';
import '../../../../themes/theme_color.dart';
import '../../../../widgets/nested_route_wrapper.dart';
import '../../../bottom_bar_screen/enum/bottom_bar_enum.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: 'Tin tức',
        ),
        backgroundColor: AppColors.bgrScafold,
        body: BlocProvider(
          create: (context) => NewsBloc()..add(InitNewsDataEvent()),
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (BuildContext context, state) {
              if (state.status == ScreenStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NewsBloc>().add(InitNewsDataEvent());
                },
                child: state.histories.isEmpty
                    ? const Center(
                        child: Text("Không có tin tức nào!"),
                      )
                    : GridView.builder(
                        itemCount: state.histories.length,
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
                          return itemNews(state.histories[index], context);
                        },
                      ),
              );
            },
          ),
        ));
  }
}
