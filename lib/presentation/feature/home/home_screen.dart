import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/home/widget/banner_home.dart';
import 'package:qrcode/presentation/feature/home/widget/filter_item.dart';
import 'package:qrcode/presentation/feature/home/widget/news_home_widget.dart';
import 'package:qrcode/presentation/feature/home/widget/product_features.dart';
import 'package:qrcode/presentation/feature/home/widget/product_sellers.dart';
import 'package:qrcode/presentation/feature/home/widget/silver_coated_shampoo_widget.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import '../../../app/route/navigation/route_names.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'bottom/home_enum.dart';

class HomeNested extends StatelessWidget {
  const HomeNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateBottomBarRoute,
      navigationKey: Routes.homeKey,
      initialRoute: BottomBarEnum.home.getRouteNames,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  late BottomBarBloc _bottomBarBloc;

  bool _isLoading = false;

  @override
  void initState() {
    _bottomBarBloc = context.read<BottomBarBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<BottomBarBloc, BottomBarState>(
      listener: (context, state) async {
        if (state.bottomBarEnum == BottomBarEnum.home && state.isRefresh) {
          await _onRefresh();
        }
      },
      child: Scaffold(
        appBar: BaseAppBar(
          leadingWidth: _isHasProfileData ? 153 : null,
          leadingIcon: _headerWidget(),
          actions: [
            _notiIcon(),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _onRefresh,
                color: Colors.white,
                backgroundColor: Colors.amber,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///banner Slider
                      const BannerHomeWidget(),

                      ///filter
                      _buildFilter(),

                      /// sản phẩm nổi bật
                      const ProductFeaturesWidget(),

                      /// sản phẩm bán chạy
                      const ProductSellersWidget(),

                      ///dầu gội phủ bạc
                      const SilverCoatedShampooWidget(),

                      ///tin mới nhất
                      const NewsHomeWidget(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _headerWidget() => _isHasProfileData
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.logoMain.image(
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Xin chào,',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  context.read<ProfileBloc>().state.profileModel?.name ?? "",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            )
          ],
        )
      : Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Assets.images.logoMain.image(
            width: 40,
            height: 40,
          ),
        );

  bool get _isHasProfileData =>
      context.read<ProfileBloc>().state.profileModel?.phone != null;

  Widget _notiIcon() => GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          RouteDefine.notiScreen,
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Icon(
              Icons.notifications_outlined,
              size: 30,
              color: Color(0xFFCCD2E3),
            ),
          ),
        ),
      );

  Widget _buildFilter() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            IconHomeEnum.values.length,
            (index) => FilterItemWidget(
              index: index,
              onTap: () {
                switch (IconHomeEnum.values[index]) {
                  case IconHomeEnum.all:

                    ///todo: update later
                    break;
                  case IconHomeEnum.shampoo:

                    ///todo: update later
                    break;
                  case IconHomeEnum.news:
                    _bottomBarBloc.add(const ChangeTabBottomBarEvent(
                        bottomBarEnum: BottomBarEnum.tinTuc));
                    break;
                  case IconHomeEnum.favourite:

                    ///todo: update later
                    break;
                  case IconHomeEnum.tool:

                    ///todo: update later
                    break;
                }
              },
            ),
          ),
        ),
      );

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(
        const Duration(seconds: 1),
        () => setState(() {
              _isLoading = false;
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
