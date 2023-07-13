import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/feature/feature/bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import 'package:qrcode/feature/feature/home/widget/banner_home.dart';
import 'package:qrcode/feature/feature/home/widget/filter_item.dart';
import 'package:qrcode/feature/feature/home/widget/news_home_widget.dart';
import 'package:qrcode/feature/feature/home/widget/product_features.dart';
import 'package:qrcode/feature/feature/home/widget/product_sellers.dart';
import 'package:qrcode/feature/feature/home/widget/silver_coated_shampoo_widget.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../../common/navigation/route_names.dart';
import '../../routes.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../../widgets/toast_manager.dart';
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
  bool _isLoading = false;

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
          leadingWidth: _isHasProfileData ? 138 : null,
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
            Image.asset(
              IconConst.logo,
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
                  injector<AppCache>().profileModel?.name ?? "",
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
          child: Image.asset(
            IconConst.logoMain,
            width: 40,
            height: 40,
          ),
        );

  bool get _isHasProfileData => injector<AppCache>().profileModel != null;

  Widget _notiIcon() => GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          RouteName.notiScreen,
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
              onTap: () => ToastManager.showToast(
                context,
                delaySecond: 1,
                text: 'chức năng sẽ sớm ra mắt',
              ),
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
