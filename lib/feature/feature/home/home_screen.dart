import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/banner_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/notification/firebase_notification.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';
import 'package:qrcode/feature/feature/news/detail_new_screen.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/banner_slide_image.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/gridview_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BannerModel> _bannerModel = [];
  List<ProductModel> _products = [];
  List<ProductModel> _productFeatures = [];
  List<ProductModel> _productSellers = [];
  List<NewsModel> _newsModel = [];
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
      setState(() {

      });
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
      RouteName.NotiScreen,
    );
  }

  void _checkAndNavigateToLastScreen() async {
    await Future.delayed(Duration(seconds: 2));
    if (injector<AppCache>().cacheDataProduct != null) {
      Routes.instance.navigateTo(RouteName.DetailProductScreen,
          arguments: ArgumentDetailProductScreen(
            url: injector<AppCache>().cacheDataProduct,
          ));
      return;
    }
    if (injector<AppCache>().cacheProductId != null) {
      Routes.instance.navigateTo(RouteName.DetailProductScreen,
          arguments: ArgumentDetailProductScreen(
            productId: injector<AppCache>().cacheProductId,
          ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoadding ? Center(
        child: CircularProgressIndicator(),
      ):RefreshIndicator(
        onRefresh: () async {
          Routes.instance.navigateTo(RouteName.ContainerScreen);
          await Future.delayed(Duration(seconds: 2));
        },  color: Colors.white,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        IconConst.logo,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                CustomGestureDetector(
                  onTap: _onScan,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.notifications,
                          size: 24,
                          color: AppColors.white,
                        ),
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
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child:
                      BannerSlideImage(
                        height: MediaQuery.of(context).size.height*0.25,
                        banners: _bannerModel.map((e) => e).toList(),
                        images: _bannerModel.map((e) => e.url ?? '').toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridViewDisplayProduct(
                      label: 'Sản phẩm nổi bật',
                      products: _productFeatures,
                      notExpand: true,
                      onMore: () {
                        Routes.instance.navigateTo(RouteName.ListProductScreen,
                            arguments: ArgumentListProductScreen(
                              url: 'product-feature',
                              label: 'Sản phẩm nổi bật',
                            ));
                      },
                    ),
                    const SizedBox(height: 12),
                    GridViewDisplayProduct(
                      label: 'Sản phẩm bán chạy',
                      products: _productSellers,
                      notExpand: true,
                      onMore: () {
                        Routes.instance.navigateTo(RouteName.ListProductScreen,
                            arguments: ArgumentListProductScreen(
                              url: 'product-seller',
                              label: 'Sản phẩm bán chạy',
                            ));
                      },
                    ),
                    const SizedBox(height: 12),
                    _newsModel.isEmpty
                        ? const SizedBox():  Row(
                      children: [
                        const SizedBox(width: 12),
                        Text(
                          'Tin tức mới nhất',
                          style: AppTextTheme.mediumBlack.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    _newsModel.isEmpty
                        ? const SizedBox()
                        : Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: ListView.builder(
                        itemBuilder: (_, index) {
                          return _itemNews(_newsModel[index]);
                        },
                        itemCount: _newsModel.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),)



      ,
    );
  }

  Widget _itemNews(NewsModel model) {
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.DetailNewScreen,
            arguments: ArgumentDetailNewScreen(
                news_detail: model.id,url:model.image
            ));
      },
      child: Container(
        width: GScreenUtil.screenWidthDp * 0.6,
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
            boxShadow: StringConst.defaultShadow,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: model.image,
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.15,
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
