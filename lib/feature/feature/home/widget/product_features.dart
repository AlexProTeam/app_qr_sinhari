import 'package:flutter/material.dart';

import '../../../../common/model/product_model.dart';
import '../../../../common/navigation/route_names.dart';
import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../injector_container.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/gridview_product.dart';
import '../../list_product/list_product_screen.dart';

class ProductFeaturesWidget extends StatefulWidget {
  const ProductFeaturesWidget({Key? key}) : super(key: key);

  @override
  State<ProductFeaturesWidget> createState() => _ProductFeaturesWidgetState();
}

class _ProductFeaturesWidgetState extends State<ProductFeaturesWidget> {
  bool _isLoading = false;
  final List<ProductResponse> _productFeatures = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 22, top: 10, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Sản phẩm nổi bật',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.colorEF4948),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    if (_productFeatures.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 22, top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridViewDisplayProduct(
          label: 'Sản phẩm nổi bật',
          products: _productFeatures,
          notExpand: true,
          onMore: () =>
              Navigator.pushNamed(context, RouteName.listProductScreen,
                  arguments: ArgumentListProductScreen(
                    url: 'product-feature',
                    label: 'Sản phẩm nổi bật',
                  )),
        ),
      ),
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      final datafeature =
          await injector<AppClient>().get('product-feature?page=1');
      datafeature['data']['productFeatures']['data'].forEach((e) {
        _productFeatures.add(ProductResponse.fromJson(e));
      });
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      _isLoading = false;
    });
  }
}
