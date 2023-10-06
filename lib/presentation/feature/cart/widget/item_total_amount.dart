import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/item_row.dart';

import '../bloc/carts_bloc.dart';

class ItemTotalAmount extends StatelessWidget {
  const ItemTotalAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.read<CartsBloc>().state.cartsResponse;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Column(
        children: [
          ItemRow(
            title: '${data?.carts?.items?.length ?? 0} sản phẩm',
            value: '${data?.carts?.getTotalSalePrice} vnđ',
          ),
          const SizedBox(
            height: 8,
          ),
          const ItemRow(title: 'Mã khuyến mại', value: '0 vnđ'),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
              title: 'Giảm giá',
              value:
                  '${((data?.carts?.getTotalOriginPrice ?? 0) - (data?.carts?.getTotalSalePrice ?? 0))} vnđ'),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
              title: 'Tổng thanh toán',
              textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.black),
              value: '${data?.carts?.getTotalSalePrice} vnđ',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.color7F2B81)),
        ],
      ),
    );
  }
}
