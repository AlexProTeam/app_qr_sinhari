import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qrcode/common/model/product_model.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/style_manager.dart';
import '../../app/route/screen_utils.dart';
import 'category_product_item.dart';

class GridViewDisplayProduct extends StatelessWidget {
  final int numberItem;
  final String label;
  final List<ProductResponse>? products;
  final bool notExpand;
  final Function()? onMore;

  const GridViewDisplayProduct({
    Key? key,
    this.numberItem = 2,
    required this.label,
    this.products,
    this.notExpand = false,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.colorEF4948)),
            InkWell(
              onTap: onMore,
              child: Text(
                'Xem thêm',
                style: TextStyleManager.normalGrey,
              ),
            )
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount:
              notExpand ? min(products?.length ?? 0, 4) : products?.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.61,
          ),
          itemBuilder: (context, index) {
            return CategoryItemProduct(
              itemWidth: itemWidth,
              productModel: products?[index],
              isShowLike: false,
            );
          },
        ),
      ],
    );
  }
}
