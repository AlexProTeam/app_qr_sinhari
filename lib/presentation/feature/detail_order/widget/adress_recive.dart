import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/string_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/feature/infomation_customer/widget/infor_enum.dart';

import '../../../../domain/entity/detail_order_response.dart';
import 'item_row.dart';

class InformationDetailOrdersWidget extends StatefulWidget {
  final OrderDetail orderDetail;

  const InformationDetailOrdersWidget({Key? key, required this.orderDetail})
      : super(key: key);

  @override
  State<InformationDetailOrdersWidget> createState() =>
      _InformationDetailOrdersWidgetState();
}

class _InformationDetailOrdersWidgetState
    extends State<InformationDetailOrdersWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpace,
        infoReciver(),
        const Divider(),
        infoOrder(),
        itemAmount(),
        100.verticalSpace,
      ],
    );
  }

  Widget infoReciver() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Địa chỉ nhận hàng',
            style: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.black),
          ),
          10.verticalSpace,
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
                color: AppColors.grey3,
                borderRadius: BorderRadius.circular(8.r)),
            child: Text(
              widget.orderDetail.customerAddress ?? '',
              style: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoOrder() {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          ItemRow(
              title: 'Thông tin đơn hàng',
              value: '',
              textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.black)),
          8.verticalSpace,
          ItemRow(title: 'Mã đơn hàng', value: widget.orderDetail.code ?? ''),
          8.verticalSpace,
          ItemRow(
              title: 'Trạng thái',
              value: widget.orderDetail.status?.label ?? '',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: HelperInfor.getColor(
                      widget.orderDetail.status?.value ?? ''))),
          8.verticalSpace,
          ItemRow(
            title: 'Thời gian đặt',
            value: widget.orderDetail.getCreateAt,
          ),
          // const SizedBox(height: 8),
          ///todo: update date next vesion
          // ItemRow(
          //     title: 'Hình thức giao hàng',
          //     value: widget.orderDetail.customer_address ?? ''),
          // const SizedBox(height: 8),
          ///todo: update date next vesion
          // ItemRow(
          //     title: 'Hình thức thanh toán',
          //     value: widget.orderDetail.description ?? ''),
          const Divider(),
        ],
      ),
    );
  }

  Widget itemAmount() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          ItemRow(
              title: 'Tổng tiền',
              value:
                  '${widget.orderDetail.amount.toAppNumberFormatWithNull} vnđ'),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
            title: 'Phí vận chuyển',
            value: '${widget.orderDetail.shippingAmount ?? '0'} vnđ',
          ),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
              title: 'Mã khuyến mại',
              value: '${widget.orderDetail.discountAmount ?? '0'} vnđ'),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
            title: 'Tổng thanh toán',
            textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.black),
            value:
                '${widget.orderDetail.subTotal.toAppNumberFormatWithNull} vnđ',
            textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.color7F2B81),
          ),
        ],
      ),
    );
  }
}
