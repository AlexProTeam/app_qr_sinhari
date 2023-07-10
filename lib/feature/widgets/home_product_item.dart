import 'package:flutter/material.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

import '../../common/const/icon_constant.dart';
import '../../common/model/product_model.dart';
import '../themes/theme_color.dart';
import 'custom_image_network.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.productModel}) : super(key: key);
  final ProductResponse? productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteName.detailProductScreen,
          arguments: ArgumentDetailProductScreen(
            productId: productModel?.id,
          )),
      child: Container(
        height: 134,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: AppColors.bgrScafold,
          borderRadius: BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: '${productModel?.thumbnailImg}',
              fit: BoxFit.cover,
              width: 110,
              height: 110,
              border: 8,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 164,
                  child: Text(
                    productModel?.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.3),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      IconConst.star,
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        text: productModel?.rating.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                        children: const [
                          TextSpan(
                            ///todo: hard code
                            text: ' (122 sản phẩm)',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: AppColors.colorACACAC),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      FormatUtils.formatCurrencyDoubleToString(
                          productModel?.purchasePrice ??
                              productModel?.unitPrice),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFC700)),
                    ),
                    const SizedBox(width: 15),
                    RichText(
                      text: TextSpan(
                        text: FormatUtils.formatCurrencyDoubleToString(
                            productModel?.purchasePrice ??
                                productModel?.unitPrice),
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
                    const SizedBox(width: 25),
                    InkWell(
                      onTap: () => ToastManager.showToast(context,
                          text: 'Chức năng này sẽ sớm ra mắt'),
                      child: Image.asset(
                        IconConst.heart,
                        width: 22,
                        height: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
