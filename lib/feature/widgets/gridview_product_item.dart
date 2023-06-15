import 'package:flutter/material.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

class CategoryDetailWidgetItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductModel? productModel;

  const CategoryDetailWidgetItemProduct({
    Key? key,
    required this.itemWidth,
    this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sizeImage = itemWidth + 10;
    return InkWell(
      onTap: () {
        if (injector<AppCache>().profileModel == null) {
          injector<AppCache>().cacheProductId = productModel?.id;
        }
        Routes.instance.navigateTo(RouteName.DetailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: productModel?.id,
            ));
      },
      child: Expanded(
        child: Column(
          children: [
            Container(
                // height: _sizeImage + 28,
                width: _sizeImage - 15,
                child: CustomImageNetwork(
                  url: '${productModel?.thumbnailImg}',
                  fit: BoxFit.cover,
                  // width: double.infinity,
                  border: 12,
                ),
              ),
            SizedBox(height: 10),
            Text('${productModel?.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black)),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '${FormatUtils.formatCurrencyDoubleToString(productModel?.purchasePrice ?? productModel?.unitPrice)}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFFC700)),
                ),
                // const Spacer(),
                SizedBox(width: 5),
                Text(
                  '${FormatUtils.formatCurrencyDoubleToString(productModel?.purchasePrice ?? productModel?.unitPrice)}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFACACAC)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
