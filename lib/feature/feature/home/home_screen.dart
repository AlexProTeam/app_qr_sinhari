import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/model/banner_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/home/widget/filter_item.dart';
import 'package:qrcode/feature/feature/home/widget/item_news.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/home_product_item.dart';

import '../../../common/navigation/route_names.dart';
import '../../routes.dart';
import '../../widgets/banner_slide_image.dart';
import '../../widgets/gridview_product.dart';
import '../list_product/list_product_screen.dart';

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

  Future<void> _initData() async {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadding
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: _initData,
            color: Colors.white,
            backgroundColor: Colors.amber,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        IconConst.logo,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Routes.instance.navigateTo(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              onMore: () => getGoToScreen(
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
                                  onTap: () => getGoToScreen(
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
                                onTap: () {},
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Tin tức mới nhất',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFEF4948))),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 220,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
              ],
            ),
          );
  }

  void getGoToScreen({required String url, required String label}) =>
      Navigator.pushNamed(context, RouteName.listProductScreen,
          arguments: ArgumentListProductScreen(
            url: url,
            label: label,
          ));
}
