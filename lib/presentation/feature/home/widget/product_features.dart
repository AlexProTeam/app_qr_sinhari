import 'package:flutter/material.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/product_model.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/route/navigation/route_names.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../widgets/gridview_product.dart';
import '../../../widgets/toast_manager.dart';
import '../../list_product/list_product_screen.dart';

class ProductFeaturesWidget extends StatefulWidget {
  const ProductFeaturesWidget({Key? key}) : super(key: key);

  @override
  State<ProductFeaturesWidget> createState() => _ProductFeaturesWidgetState();
}

class _ProductFeaturesWidgetState extends State<ProductFeaturesWidget> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridViewDisplayProduct(
        label: 'Sản phẩm nổi bật',
        products: _productFeatures,
        notExpand: true,
        onMore: () =>
            Navigator.pushNamed(context, RouteDefine.listProductScreen,
                arguments: ArgumentListProductScreen(
                  url: 'product-feature',
                  label: 'Sản phẩm nổi bật',
                )),
      ),
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _appUseCase.getListFeature();

      _productFeatures.addAll(result.data?.productFeatures?.list ?? []);
    } on ApiException catch (e) {
      ToastManager.showToast(context, text: e.message);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
