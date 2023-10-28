import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/string_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/widgets/custom_image_network.dart';

import '../../../../domain/entity/detail_order_response.dart';

class ItemListViewDetailOrdersWidget extends StatelessWidget {
  final Products products;

  const ItemListViewDetailOrdersWidget({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.colorF1F1F1))),
      child: Row(
        children: [
          CustomImageNetwork(
            url: products.productImage ?? '',
            width: 111.w,
            height: 9.h,
            border: 8.r,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.productName ?? '',
                    style: TextStyleManager.mediumBlack14px
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${products.price.toAppNumberFormatWithNull} vnđ',
                          style: TextStyleManager.mediumBlack14px.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.color7F2B81,
                          ),
                        ),
                      ),

                      ///todo: check in next time
                      // Expanded(
                      //   child: Text(
                      //     '${products.product?.salePrice} vnđ',
                      //     style: TextStyleManager.mediumBlack14px.copyWith(
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: 14,
                      //         decoration: TextDecoration.lineThrough),
                      //     textAlign: TextAlign.right,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Số lượng: ${products.qty}',
                    style: TextStyleManager.mediumBlack14px
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
