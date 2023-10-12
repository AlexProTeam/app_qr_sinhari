import 'package:flutter/material.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/home_response.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../widgets/home_product_item.dart';
import '../../../widgets/toast_manager.dart';

class SilverCoatedShampooWidget extends StatefulWidget {
  const SilverCoatedShampooWidget({Key? key}) : super(key: key);

  @override
  State<SilverCoatedShampooWidget> createState() =>
      _SilverCoatedShampooWidgetState();
}

class _SilverCoatedShampooWidgetState extends State<SilverCoatedShampooWidget> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();
  bool _isLoading = false;
  final List<HomeCategoryResponse> _homeCategory = [];

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
              'Dầu gội phủ bạc',
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

    if (_homeCategory.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .copyWith(bottom: 22, top: 10),
      child: Column(
        children: _homeCategory.map(
          (e) {
            final dataProduct = e.products ?? [];

            if (dataProduct.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                const SizedBox(
                  height: 22,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e.title ?? 'Dầu gội phủ bạc',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.colorEF4948),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () => ToastManager.showToast(
                        context,
                        text: 'Chức năng sẽ sớm ra mắt',
                      ),
                      child: Text(
                        'Xem thêm',
                        style: TextStyleManager.normalGrey,
                      ),
                    )
                  ],
                ),
                ...List.generate(
                  dataProduct.length,
                  (index) => ProductItemHome(
                    productModel: dataProduct[index],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }

  Future<void> _initData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _appUseCase.getHomeCategory();

      _homeCategory.addAll(result);
    } on ApiException catch (e) {
      ToastManager.showToast(context, text: e.message);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
