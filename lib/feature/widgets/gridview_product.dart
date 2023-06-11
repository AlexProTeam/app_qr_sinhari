import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/gridview_product_item.dart';

class GridViewDisplayProduct extends StatelessWidget {
  final int numberItem;
  final String label;
  final List<ProductModel>? products;
  final bool notExpand;
  final Function? onMore;

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
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 50;
    final numberRow = CommonUtil.countNumberRowOfGridview(products);
    final heightList =
        (notExpand ? min(numberRow, 2) : numberRow) * (_itemHeight + 25);
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextTheme.mediumBlack.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (onMore != null) {
                  onMore!();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Xem thêm',
                  style: AppTextTheme.normalGrey,
                ),
              ),
            )
          ],
        ),
        Container(
          width: double.infinity,
          height: heightList,
          child: GridView.builder(
            itemCount:
                notExpand ? min(products?.length ?? 0, 4) : products?.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: _itemWidth / _itemHeight,
            ),
            itemBuilder: (context, index) {
              return CategoryDetailWidgetItemProduct(
                itemWidth: _itemWidth,
                productModel: products?[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
