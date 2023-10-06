import 'package:flutter/material.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/helper.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../app/managers/color_manager.dart';
import '../../app/route/format_utils.dart';
import '../../app/route/navigation/route_names.dart';
import 'custom_image_network.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.productModel, this.isAngecy = false})
      : super(key: key);
  final ProductResponse? productModel;
  final bool? isAngecy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        boxShadow: AppConstant.defaultShadow,
        color: AppColors.bgrScafold,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, RouteDefine.detailProductScreen,
                arguments: ArgumentDetailProductScreen(
                  productId: productModel?.id,
                )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: CustomImageNetwork(
                url: '${productModel?.thumbnailImg}',
                fit: BoxFit.cover,
                width: 110,
                height: 110,
                border: 8,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productModel?.name ?? '',
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
                    Row(
                      children: [
                        Assets.icons.star.image(
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 6),
                        RichText(
                          text: TextSpan(
                            text: (productModel?.rating ?? 0).toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text:
                                    ' (${(productModel?.quantity ?? 0).toString()} Sản phẩm)',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.colorACACAC),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    itemPrice(
                      salePrice: isAngecy == true
                          ? productModel?.salePrice ?? 0
                          : productModel?.unitPrice ?? 0,
                      price: isAngecy == true
                          ? productModel?.price ?? 0
                          : productModel?.purchasePrice ?? 0,
                    ),
                    InkWell(
                      onTap: () => ToastManager.showToast(
                        context,
                        text: 'Chức năng này sẽ sớm ra mắt',
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Assets.icons.heart.image(
                          width: 22,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemPrice({required int salePrice, required int price}) {
    if (Helper.getPrice(salePrice, price) == false) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (productModel?.unitPrice == null) ...[
                const SizedBox(height: 5),
                Text(
                  FormatUtils.formatCurrencyDoubleToString(price),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorFFC700),
                ),
              ],
              if (productModel?.unitPrice != null) ...[
                const SizedBox(height: 5),
                Text(
                  FormatUtils.formatCurrencyDoubleToString(salePrice),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorFFC700),
                ),
                const SizedBox(width: 15),
                RichText(
                  text: TextSpan(
                    text: FormatUtils.formatCurrencyDoubleToString(
                      price,
                    ),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorACACAC,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.colorACACAC,
                      height: 2,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 5),
          Text(
            FormatUtils.formatCurrencyDoubleToString(price),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.colorFFC700),
          ),
        ],
      );
    }
  }
}
