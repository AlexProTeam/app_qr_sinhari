import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/model/banner_model.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/banner_slide_image.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
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

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get('banners');
      data['data'].forEach((e) {
        _bannerModel.add(BannerModel.fromJson(e));
      });
      final dataProduct1 = await injector<AppClient>().get('list-product');
      dataProduct1['data']['products'].forEach((e) {
        _products.add(ProductModel.fromJson(e));
      });
      dataProduct1['data']['productFeatures'].forEach((e) {
        _productFeatures.add(ProductModel.fromJson(e));
      });
      dataProduct1['data']['productSellers'].forEach((e) {
        _productSellers.add(ProductModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomGestureDetector(
                  onTap: () {
                    Routes.instance.navigateTo(RouteName.PersonalScreen);
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        IconConst.scan,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: BannerSlideImage(
                height: 183,
                images: _bannerModel.map((e) => e.url ?? '').toList(),
              ),
            ),
            const SizedBox(height: 12),
            GridViewDisplayProduct(
              label: 'Gợi ý',
              products: _products,
              notExpand: true,
              onMore: () {
                Routes.instance.navigateTo(RouteName.ListProductScreen,
                    arguments: ArgumentListProductScreen(
                      products: _products,
                      label: 'Gợi ý',
                    ));
              },
            ),
            const SizedBox(height: 12),
            GridViewDisplayProduct(
              label: 'Sản phẩm nổi bật',
              products: _productFeatures,
              notExpand: true,
              onMore: () {
                Routes.instance.navigateTo(RouteName.ListProductScreen,
                    arguments: ArgumentListProductScreen(
                      products: _productFeatures,
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
                      products: _productSellers,
                      label: 'Sản phẩm bán chạy',
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
