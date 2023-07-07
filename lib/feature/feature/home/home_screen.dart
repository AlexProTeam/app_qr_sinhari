import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/banner_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import 'package:qrcode/feature/feature/home/widget/filter_item.dart';
import 'package:qrcode/feature/feature/home/widget/item_news.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/home_product_item.dart';

import '../../../common/navigation/route_names.dart';
import '../../routes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/banner_slide_image.dart';
import '../../widgets/gridview_product.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../../widgets/toast_manager.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import '../list_product/list_product_screen.dart';
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
  final List<BannerModel> _bannerModel = [];
  final List<ProductModel> _productFeatures = [];
  final List<ProductModel> _productSellers = [];
  final List<NewsModel> _newsModel = [];
  bool _isLoading = false;

  Future<void> _initData() async {
    try {
      _isLoading = true;
      final data = await injector<AppClient>().get('banners');
      await injector<AppClient>().post('notifications',
          body: {"device_id": FirebaseNotification.instance.deviceToken},
          handleResponse: false);
      data['data'].forEach((e) {
        _bannerModel.add(BannerModel.fromJson(e));
      });
      final dataNew =
          await injector<AppClient>().post('list_news', handleResponse: false);
      dataNew['data'].forEach((e) {
        _newsModel.add(NewsModel.fromJson(e));
      });

      final dataSeller =
          await injector<AppClient>().get('product-seller?page=1');
      final datafeature =
          await injector<AppClient>().get('product-feature?page=1');
      datafeature['data']['productFeatures']['data'].forEach((e) {
        _productFeatures.add(ProductModel.fromJson(e));
      });
      dataSeller['data']['productSellers']['data'].forEach((e) {
        _productSellers.add(ProductModel.fromJson(e));
      });
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      CommonUtil.handleException(null, e, methodName: '');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _onRefresh() async {
    _bannerModel.clear();
    _productFeatures.clear();
    _productSellers.clear();
    _newsModel.clear();
    await _initData();
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<BottomBarBloc, BottomBarState>(
      listenWhen: (previous, current) =>
          previous.bottomBarEnum != current.bottomBarEnum &&
          current.bottomBarEnum == BottomBarEnum.home,
      listener: (context, state) =>
          state.bottomBarEnum == BottomBarEnum.home ? _onRefresh() : null,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          color: Colors.white,
          backgroundColor: Colors.amber,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: injector<AppCache>().profileModel != null
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            injector<AppCache>()
                                                    .profileModel
                                                    ?.name ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Image.asset(
                                    IconConst.logo,
                                    width: 40,
                                    height: 40,
                                  ),
                          ),
                          GestureDetector(
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
                          )
                        ],
                      ),
                      BannerSlideImage(
                        height: MediaQuery.of(context).size.height * 0.22,
                        banners: _bannerModel.map((e) => e).toList(),
                        images: _bannerModel.map((e) => e.url ?? '').toList(),
                      ),
                      const SizedBox(height: 22.5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      ),
                      const SizedBox(height: 20),
                      if (_productFeatures.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridViewDisplayProduct(
                            label: 'Sản phẩm nổi bật',
                            products: _productFeatures,
                            notExpand: true,
                            onMore: () => getGoToDetailScreen(
                              url: 'product-feature',
                              label: 'Sản phẩm nổi bật',
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                      ],
                      if (_productSellers.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sản phẩm bán chạy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Color(0xFFEF4948))),
                              InkWell(
                                onTap: () => getGoToDetailScreen(
                                  url: 'product-seller',
                                  label: 'Sản phẩm bán chạy',
                                ),
                                child: const Text(
                                  'Xem thêm',
                                  style: AppTextTheme.normalGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _productSellers.length,
                            itemBuilder: (_, index) {
                              return ProductItem(
                                productModel: _productSellers[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 22),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Dầu gội phủ bạc',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Color(0xFFEF4948))),
                            InkWell(
                              onTap: () => getGoToDetailScreen(
                                url: 'product-seller',
                                label: 'Dầu gội phủ bạc',
                              ),
                              child: const Text(
                                'Xem thêm',
                                style: AppTextTheme.normalGrey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _productSellers.length,
                          itemBuilder: (_, index) {
                            return ProductItem(
                              productModel: _productSellers[index],
                            );
                          },
                        ),
                      ),
                      if (_newsModel.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16)
                              .copyWith(bottom: 12),
                          child: const Text('Tin tức mới nhất',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,

                                  ///todo: add const
                                  color: Color(0xFFEF4948))),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 220,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shrinkWrap: true,
                            itemBuilder: (_, index) => ItemNews(
                              model: _newsModel[index],
                            ),
                            itemCount: _newsModel.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void getGoToDetailScreen({required String url, required String label}) =>
      Navigator.pushNamed(context, RouteName.listProductScreen,
          arguments: ArgumentListProductScreen(
            url: url,
            label: label,
          ));

  @override
  bool get wantKeepAlive => true;
}
