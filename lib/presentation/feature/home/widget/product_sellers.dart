import 'package:flutter/material.dart';

import '../../../../../common/model/product_model.dart';
import '../../../../app/di/injection.dart';
import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../app/route/navigation/route_names.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/login/usecases/app_usecase.dart';
import '../../../widgets/home_product_item.dart';
import '../../../widgets/toast_manager.dart';
import '../../list_product/list_product_screen.dart';

class ProductSellersWidget extends StatefulWidget {
  const ProductSellersWidget({Key? key}) : super(key: key);

  @override
  State<ProductSellersWidget> createState() => _ProductSellersWidgetState();
}

class _ProductSellersWidgetState extends State<ProductSellersWidget> {
  bool _isLoading = false;
  final List<ProductResponse> _productSellers = [];
  final AppUseCase _appUseCase = getIt<AppUseCase>();

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
              'Sản phẩm bán chạy',
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

    if (_productSellers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .copyWith(bottom: 22, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sản phẩm bán chạy',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.colorEF4948)),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, RouteDefine.listProductScreen,
                        arguments: ArgumentListProductScreen(
                          url: 'product-seller',
                          label: 'Sản phẩm bán chạy',
                        )),
                child: Text(
                  'Xem thêm',
                  style: TextStyleManager.normalGrey,
                ),
              )
            ],
          ),
          ...List.generate(
              _productSellers.length,
              (index) => ProductItem(
                    productModel: _productSellers[index],
                  )),
        ],
      ),
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _appUseCase.getListSeller();

      _productSellers.addAll(result.data?.productSellers?.list ?? []);
    } on ApiException catch (e) {
      ToastManager.showToast(context, text: e.message);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
