import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

import '../themes/theme_color.dart';

class CategoryItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductResponse? productModel;

  const CategoryItemProduct({
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
          CustomImageNetwork(
            url: '${productModel?.thumbnailImg}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 164,
            border: 12,
          ),
          const SizedBox(height: 16.25),
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
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                IconConst.star,
                width: 13.5,
                height: 13,
              ),
              const SizedBox(width: 6),
              RichText(
                  text: const TextSpan(
                      text: '4.9 ',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                      children: [
                    TextSpan(
                      text: '(122 sản phẩm)',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.colorACACAC),
                    )
                  ]))
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatUtils.formatCurrencyDoubleToString(
                      productModel?.purchasePrice ?? productModel?.unitPrice),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorFFC700),
                ),
                // const Spacer(),
                RichText(
                  text: TextSpan(
                    text: FormatUtils.formatCurrencyDoubleToString(
                        productModel?.purchasePrice ?? productModel?.unitPrice),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorACACAC,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.colorACACAC,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  IconConst.heart,
                  width: 22,
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
