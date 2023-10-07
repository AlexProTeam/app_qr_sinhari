import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/num_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/item_row.dart';

import '../../../../domain/entity/list_carts_response.dart';

class ItemTotalAmount extends StatelessWidget {
  final ListCartsResponse listCartsResponse;

  const ItemTotalAmount({Key? key, required this.listCartsResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Column(
        children: [
          ItemRow(
            title: '${listCartsResponse.carts?.getItemsQtyNum ?? '0'} sản phẩm',
            value:
                '${listCartsResponse.carts?.getTotalOriginPrice.toAppNumberFormat ?? 0} vnđ',
          ),
          8.verticalSpace,
          const ItemRow(title: 'Mã khuyến mại', value: '0 vnđ'),
          8.verticalSpace,
          ItemRow(
            title: 'Giảm giá',
            value:
                '${(listCartsResponse.carts?.getDisCountPrice ?? 0).toAppNumberFormat} vnđ',
          ),
          8.verticalSpace,
          ItemRow(
              title: 'Tổng thanh toán',
              textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.black,
              ),
              value:
                  '${listCartsResponse.carts?.getTotalPriceQty.toAppNumberFormat ?? 0} vnđ',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.color7F2B81)),
        ],
      ),
    );
  }
}
