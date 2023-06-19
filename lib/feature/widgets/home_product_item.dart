import 'package:flutter/material.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/routes.dart';

import '../../common/const/icon_constant.dart';
import '../../common/model/product_model.dart';
import 'custom_image_network.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.productModel}) : super(key: key);
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () => Routes.instance.navigateTo(RouteName.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: productModel?.id,
            )),
        child: Container(
          width: 343,
          height: 132,
          decoration: const BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.all(Radius.circular(
                8,
              ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageNetwork(
                url: '${productModel?.thumbnailImg}',
                fit: BoxFit.cover,
                width: 110,
                height: 110,
                border: 8,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                      width: 164,
                      child: Text('${productModel?.name}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black))),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        IconConst.star,
                        width: 13.5,
                        height: 16,
                      ),
                      const SizedBox(width: 6),
                      RichText(
                          text: const TextSpan(
                              text: '4.9 ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              children: [
                            TextSpan(
                              text: '(122 sản phẩm)',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFFACACAC)),
                            )
                          ]))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFACACAC),
                            decoration: TextDecoration.lineThrough,
                            decorationColor:
                                Color(0xFFACACAC), // Màu của đường gạch ngang),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Image.asset(
                        IconConst.heart,
                        width: 22,
                        height: 20,
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
