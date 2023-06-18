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
    return InkWell(
      onTap: () {
        if (injector<AppCache>().profileModel == null) {
          injector<AppCache>().cacheProductId = productModel?.id;
        }
        Routes.instance.navigateTo(RouteName.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: productModel?.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageNetwork(
            url: '${productModel?.thumbnailImg}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            border: 12,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: Text('${productModel?.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black)),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                FormatUtils.formatCurrencyDoubleToString(
                    productModel?.purchasePrice ?? productModel?.unitPrice),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFC700)),
              ),
              // const Spacer(),
              const SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  text: FormatUtils.formatCurrencyDoubleToString(
                      productModel?.purchasePrice ?? productModel?.unitPrice),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFACACAC),
                    decoration: TextDecoration.lineThrough,
                    decorationColor:
                        Color(0xFFACACAC), // Màu của đường gạch ngang),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
