import 'package:flutter/material.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

import '../../common/const/string_const.dart';
import '../themes/theme_color.dart';

class CategoryDetailWidgetItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductResponse? productModel;

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
        Navigator.pushNamed(context, RouteName.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: productModel?.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: StringConst.defaultShadow,
            ),
            child: CustomImageNetwork(
              url: '${productModel?.thumbnailImg}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              border: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${productModel?.name}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                FormatUtils.formatCurrencyDoubleToString(
                    productModel?.unitPrice),
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFC700)),
              ),
              const SizedBox(width: 5),
              RichText(
                text: TextSpan(
                  text: FormatUtils.formatCurrencyDoubleToString(
                    productModel?.purchasePrice,
                  ),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorACACAC,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.colorACACAC,
                    height: 1.3,
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
