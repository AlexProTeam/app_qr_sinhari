import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/domain/entity/detail_order.dart';

class ItemList extends StatelessWidget {
  final Products products;

  const ItemList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.colorF1F1F1))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              products.productImage ?? '',
              width: 111,
              height: 95,
              // fit: BoxFit.cover,
            ),
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
                          '${products.price} vnđ',
                          style: TextStyleManager.mediumBlack14px.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.color7F2B81,
                          ),
                        ),
                      ),
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
