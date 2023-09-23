import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';

import '../../../../../app/managers/color_manager.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../../../../widgets/nested_route_wrapper.dart';
import '../../../bottom_bar_screen/enum/bottom_bar_enum.dart';
import '../bloc/news_bloc.dart';
import '../widget/item_news.dart';

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
              if (state.status == BlocStatusEnum.loading) {
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.5,
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
