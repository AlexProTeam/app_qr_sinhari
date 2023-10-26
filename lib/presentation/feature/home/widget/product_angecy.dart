import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/product_model.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/route_names.dart';
import '../../../../app/managers/status_bloc.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../widgets/home_product_item.dart';
import '../../../widgets/toast_manager.dart';
import '../../detail_product/bloc/product_detail_bloc.dart';
import '../../list_product/list_product_screen.dart';

class ProductAngecyHomeWidget extends StatefulWidget {
  const ProductAngecyHomeWidget({Key? key}) : super(key: key);

  @override
  State<ProductAngecyHomeWidget> createState() =>
      _ProductAngecyHomeWidgetState();
}

class _ProductAngecyHomeWidgetState extends State<ProductAngecyHomeWidget> {
  final List<ProductResponse> _productAngecy = [];
  final AppUseCase _appUseCase = getIt<AppUseCase>();
  bool _isLoading = true;

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
              'Sản phẩm đại lý',
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

    if (_productAngecy.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) => previous != current,
      listener: (context, state) {
        state.status == BlocStatusEnum.loading
            ? DialogManager.showLoadingDialog(context)
            : DialogManager.hideLoadingDialog;

        if (state.errMes.isNotEmpty) {
          ToastManager.showToast(
            context,
            text: state.errMes,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16)
              .copyWith(bottom: 22, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sản phẩm đại lý',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.colorEF4948)),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteDefine.listProductScreen,
                      arguments: ArgumentListProductScreen(
                        url: 'product_agency',
                        label: 'Sản phẩm đại lý',
                        isAgency: true,
                      ),
                    ),
                    child: Text(
                      'Xem thêm',
                      style: TextStyleManager.normalGrey,
                    ),
                  )
                ],
              ),
              ...List.generate(
                _productAngecy.length,
                (index) => ProductItemHome(
                  isAgency: true,
                  productModel: _productAngecy[index],
                  onTapAddToCart: () => context.read<ProductDetailBloc>().add(
                        OnAddToCartEvent(
                          proId: _productAngecy[index].id ?? 0,
                        ),
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _appUseCase.getListAngecy();

      _productAngecy.addAll(result.data?.listAngecy ?? []);
    } on ApiException catch (e) {
      ToastManager.showToast(context, text: e.message);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
