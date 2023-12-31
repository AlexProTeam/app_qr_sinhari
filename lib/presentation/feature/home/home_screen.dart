import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/home/widget/banner_home.dart';
import 'package:qrcode/presentation/feature/home/widget/filter_item.dart';
import 'package:qrcode/presentation/feature/home/widget/product_angecy.dart';
import 'package:qrcode/presentation/feature/home/widget/product_features.dart';
import 'package:qrcode/presentation/feature/home/widget/product_sellers.dart';
import 'package:qrcode/presentation/feature/home/widget/silver_coated_shampoo_widget.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import '../../../app/managers/route_names.dart';
import '../../../app/managers/status_bloc.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../../widgets/qty_carts_widget.dart';
import '../../widgets/toast_manager.dart';
import '../bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import '../cart/bloc/carts_bloc.dart';
import '../detail_product/bloc/product_detail_bloc.dart';
import '../detail_product/ui/detail_product_screen.dart';
import 'bottom/home_enum.dart';

class HomeNested extends StatelessWidget {
  const HomeNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateDefaultRoute,
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
  late ProfileBloc _profileBloc;

  bool _isLoading = false;

  @override
  void initState() {
    _profileBloc = context.read<ProfileBloc>();
    _bottomBarBloc = context.read<BottomBarBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (SessionUtils.qtyCartsList.isEmpty &&
        _profileBloc.state.profileModel?.isAgency == true) {
      context.read<CartsBloc>().add(const InitDataCartEvent());
    }
    return BlocListener<BottomBarBloc, BottomBarState>(
      listener: (context, state) async {
        if (state.bottomBarEnum == BottomBarEnum.home && state.isRefresh) {
          await _onRefresh();
        }
      },
      child: Scaffold(
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
                      ///header
                      _headerWidget(),

                      ///banner Slider
                      const BannerHomeWidget(),

                      ///filter
                      _buildFilter(),

                      /// danh sách sản phẩm
                      ..._getListProduct(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  List<Widget> _getListProduct() =>
      _profileBloc.state.profileModel?.isAgency == true
          ? [
              /// sản phẩm đại lý
              const ProductAngecyHomeWidget(),
            ]
          : [
              /// sản phẩm nổi bật
              const ProductFeaturesWidget(),

              /// sản phẩm bán chạy
              const ProductSellersWidget(),

              ///dầu gội phủ bạc
              const SilverCoatedShampooWidget(),
            ];

  Widget _headerWidget() => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Row(
            children: [
              _isHasProfileData
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        16.horizontalSpace,
                        Assets.images.logoMain.image(
                          width: 30.r,
                          height: 30.r,
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
                            3.verticalSpace,
                            Text(
                              _profileBloc.state.profileModel?.name ?? "",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Assets.images.logoMain.image(
                        width: 30.r,
                        height: 30.r,
                      ),
                    ),
              const Spacer(),
              if (_profileBloc.state.profileModel?.isAgency ?? false)
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    Routes.instance.navigatorKey.currentContext!,
                    RouteDefine.cartScreen,
                  ),
                  child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
                    listener: (context, state) {
                      state.status == BlocStatusEnum.loading
                          ? DialogManager.showLoadingDialog(context)
                          : DialogManager.hideLoadingDialog;

                      if (state.isNavigateToCartScreen &&
                          _profileBloc.state.profileModel?.isAgency == true) {
                        Navigator.pushNamed(
                          Routes.instance.navigatorKey.currentContext!,
                          RouteDefine.cartScreen,
                          arguments: ArgumentCartScreen(
                            carts: state.addToCartModel?.carts,
                          ),
                        );
                      }

                      if (state.errMes.isNotEmpty) {
                        ToastManager.showToast(
                          context,
                          text: state.errMes,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: Stack(
                          children: [
                            Assets.icons.icCar.image(
                              width: 25.r,
                              height: 25.r,
                            ),
                            qtyCartsWidget(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              _notiIcon(),
            ],
          ),
        ),
      );

  bool get _isHasProfileData => _profileBloc.state.isHasProfileData;

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
                    return _bottomBarBloc.add(
                      const ChangeTabBottomBarEvent(
                          bottomBarEnum: BottomBarEnum.tinTuc),
                    );
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
        const Duration(seconds: 3),
        () => setState(() {
              _isLoading = false;
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
