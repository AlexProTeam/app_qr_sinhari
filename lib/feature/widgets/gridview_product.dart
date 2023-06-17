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
    final itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final itemHeight = itemWidth + 50;
    final numberRow = CommonUtil.countNumberRowOfGridview(products);
    final heightList =
        (notExpand ? min(numberRow, 2) : numberRow) * (itemHeight + 70);
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFFEF4948))),
            const Spacer(),
            InkWell(
              onTap: () {
                if (onMore != null) {
                  onMore!();
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Xem thêm',
                  style: AppTextTheme.normalGrey,
                ),
              ),
            )
          ],
        ),
        // SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: heightList,
          child: GridView.builder(
            itemCount:
                notExpand ? min(products?.length ?? 0, 4) : products?.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 164 / 269,
            ),
            itemBuilder: (context, index) {
              return Expanded(
                child: CategoryDetailWidgetItemProduct(
                  itemWidth: itemWidth,
                  productModel: products?[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
