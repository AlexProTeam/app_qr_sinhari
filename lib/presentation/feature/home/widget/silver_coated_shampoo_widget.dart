import 'package:flutter/material.dart';

import '../../../../../common/network/client.dart';
import '../../../../../common/response/home_response.dart';
import '../../../../app/di/injection.dart';
import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../app/route/common_util.dart';
import '../../../widgets/home_product_item.dart';
import '../../../widgets/toast_manager.dart';

class SilverCoatedShampooWidget extends StatefulWidget {
  const SilverCoatedShampooWidget({Key? key}) : super(key: key);

  @override
  State<SilverCoatedShampooWidget> createState() =>
      _SilverCoatedShampooWidgetState();
}

class _SilverCoatedShampooWidgetState extends State<SilverCoatedShampooWidget> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.title ?? 'Dầu gội phủ bạc',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.colorEF4948)),
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
                  (index) => ProductItem(
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

      await Future.delayed(const Duration(milliseconds: 2500));

      final dataHomeCategory = await getIt<AppClient>()
          .post('get_home_category', handleResponse: false);
      dataHomeCategory['data'].forEach((e) {
        _homeCategory.add(HomeCategoryResponse.fromJson(e));
      });
    } catch (e) {
      CommonUtil.handleException(e, methodName: '');
    }
    setState(() {
      _isLoading = false;
    });
  }
}
