import 'package:flutter/material.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/gridview_product_item.dart';

class GridViewDisplayProduct extends StatelessWidget {
  final int numberItem;

  const GridViewDisplayProduct({
    Key? key,
    this.numberItem = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 50;
    final heightList = numberItem * (_itemHeight + 25);

    return Container(
      width: double.infinity,
      height: heightList,
      child: GridView.builder(
        itemCount: 2 * numberItem,
        physics: numberItem != 2
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
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
          );
        },
      ),
    );
  }
}
