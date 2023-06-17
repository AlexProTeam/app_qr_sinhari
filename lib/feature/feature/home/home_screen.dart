import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/model/banner_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';
import 'package:qrcode/feature/feature/news/detail_new_screen.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/banner_slide_image.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/gridview_product.dart';

enum IconHomeEnum {
  all,
  shampoo,
  news,
  favourite,
  tool,
}

extension IconHomeEx on IconHomeEnum {
  String get getIcon {
    switch (this) {
      case IconHomeEnum.all:
        return IconConst.icon1;
      case IconHomeEnum.shampoo:
        return IconConst.icon2;
      case IconHomeEnum.news:
        return IconConst.icon3;
      case IconHomeEnum.favourite:
        return IconConst.icon4;
      case IconHomeEnum.tool:
        return IconConst.icon5;
    }
  }

  String get getTitle {
    switch (this) {
      case IconHomeEnum.all:
        return 'Tất cả';
      case IconHomeEnum.shampoo:
        return 'Dầu gội';
      case IconHomeEnum.news:
        return 'Tin tức';
      case IconHomeEnum.favourite:
        return 'Yêu thích';
      case IconHomeEnum.tool:
        return 'Dụng cụ';
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<BannerModel> _bannerModel = [];
  final List<ProductModel> _productFeatures = [];
  final List<ProductModel> _productSellers = [];
  final List<NewsModel> _newsModel = [];
  bool isLoadding = false;

  void _initData() async {
    try {
      //  injector<LoadingBloc>().add(StartLoading());
      isLoadding = true;
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
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(null, e, methodName: '');
    } finally {
      // injector<LoadingBloc>().add(FinishLoading());
      isLoadding = false;
    }
  }

  @override
  void initState() {
    _initData();
    // _checkAndNavigateToLastScreen();
    super.initState();
  }

  void _onScan() async {
    Routes.instance.navigateTo(
      RouteName.notiScreen,
    );
  }

  ///todo: remove later
  // void _checkAndNavigateToLastScreen() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   if (injector<AppCache>().cacheDataProduct != null) {
  //     Routes.instance.navigateTo(RouteName.DetailProductScreen,
  //         arguments: ArgumentDetailProductScreen(
  //           url: injector<AppCache>().cacheDataProduct,
  //         ));
  //     return;
  //   }
  //   if (injector<AppCache>().cacheProductId != null) {
  //     Routes.instance.navigateTo(RouteName.DetailProductScreen,
  //         arguments: ArgumentDetailProductScreen(
  //           productId: injector<AppCache>().cacheProductId,
  //         ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: isLoadding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                Routes.instance.navigateTo(RouteName.containerScreen);
                await Future.delayed(const Duration(seconds: 2));
              },
              color: Colors.white,
              backgroundColor: Colors.amber,
              child: Column(
                children: [
                  SizedBox(
                    height: GScreenUtil.statusBarHeight,
                  ),
                  Row(
                    children: [
                      CustomGestureDetector(
                        onTap: () {
                          // _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            IconConst.logo,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomGestureDetector(
                        onTap: _onScan,
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: BannerSlideImage(
                              height: MediaQuery.of(context).size.height * 0.22,
                              banners: _bannerModel.map((e) => e).toList(),
                              images:
                                  _bannerModel.map((e) => e.url ?? '').toList(),
                            ),
                          ),
                          const SizedBox(height: 22.5),
                          Row(
                            children: List.generate(
                              IconHomeEnum.values.length,
                              (index) => _buildBottomBarItem(index),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridViewDisplayProduct(
                            label: 'Sản phẩm nổi bật',
                            products: _productFeatures,
                            notExpand: true,
                            onMore: () {
                              Routes.instance
                                  .navigateTo(RouteName.listProductScreen,
                                      arguments: ArgumentListProductScreen(
                                        url: 'product-feature',
                                        label: 'Sản phẩm nổi bật',
                                      ));
                            },
                          ),
                          const SizedBox(height: 22),
                          GridViewDisplayProduct(
                            label: 'Sản phẩm bán chạy',
                            products: _productSellers,
                            notExpand: true,
                            onMore: () {
                              Routes.instance
                                  .navigateTo(RouteName.listProductScreen,
                                      arguments: ArgumentListProductScreen(
                                        url: 'product-seller',
                                        label: 'Sản phẩm bán chạy',
                                      ));
                            },
                          ),
                          const SizedBox(height: 22),
                          _newsModel.isEmpty
                              ? const SizedBox()
                              : Row(
                                  children: const [
                                    SizedBox(width: 16),
                                    Text('Tin tức mới nhất',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFEF4948))),
                                  ],
                                ),
                          _newsModel.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: ListView.builder(
                                        itemBuilder: (_, index) {
                                          return _itemNews(_newsModel[index]);
                                        },
                                        itemCount: _newsModel.length,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                  ],
                                ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildBottomBarItem(int index) {
    return Expanded(
      child: GestureDetector(
        // onTap: () => changeToTabIndex(index),
        child: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconHomeEnum.values[index].getIcon,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 2),
              Text(
                IconHomeEnum.values[index].getTitle,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFACACAC)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemNews(NewsModel model) {
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.detailNewScreen,
            arguments: ArgumentDetailNewScreen(
                newsDetail: model.id, url: model.image));
      },
      child: Container(
        width: GScreenUtil.screenWidthDp * 0.6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            boxShadow: StringConst.defaultShadow,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: model.image,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
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
                    style: AppTextTheme.normalRoboto,
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
