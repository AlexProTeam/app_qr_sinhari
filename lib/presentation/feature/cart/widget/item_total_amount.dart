import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/item_row.dart';

class ItemTotalAmount extends StatefulWidget {
  const ItemTotalAmount({Key? key}) : super(key: key);

  @override
  State<ItemTotalAmount> createState() => _ItemTotalAmountState();
}

class _ItemTotalAmountState extends State<ItemTotalAmount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          const ItemRow(title: '2 sản phẩm', value: '200.000 vnđ'),
          const SizedBox(
            height: 8,
          ),
          const ItemRow(title: 'Mã khuyến mại', value: '200.000 vnđ'),
          const SizedBox(
            height: 8,
          ),
          const ItemRow(title: 'Giảm giá', value: '200.000 vnđ'),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
              title: 'Tổng thanh toán',
              textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.black),
              value: '200.000 vnđ',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.color7F2B81)),
        ],
      ),
    );
  }
}
