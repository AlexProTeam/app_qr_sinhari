import 'package:flutter/material.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

import '../../common/const/icon_constant.dart';
import '../../common/const/string_const.dart';
import '../../common/model/product_model.dart';
import '../themes/theme_color.dart';
import 'custom_image_network.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.productModel}) : super(key: key);
  final ProductResponse? productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        boxShadow: StringConst.defaultShadow,
        color: AppColors.bgrScafold,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, RouteName.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: productModel?.id,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: '${productModel?.thumbnailImg}',
              fit: BoxFit.cover,
              width: 110,
              height: 110,
              border: 8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
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
                      Image.asset(
                        IconConst.star,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FormatUtils.formatCurrencyDoubleToString(
                            productModel?.unitPrice),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.colorFFC700),
                      ),
                      const SizedBox(width: 15),
                      RichText(
                        text: TextSpan(
                          text: FormatUtils.formatCurrencyDoubleToString(
                            productModel?.purchasePrice,
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
                      InkWell(
                        onTap: () => ToastManager.showToast(
                          context,
                          text: 'Chức năng này sẽ sớm ra mắt',
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            IconConst.heart,
                            width: 22,
                            height: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
