import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/domain/entity/detail_order.dart';
import 'package:qrcode/presentation/feature/infomation_customer/widget/infor_enum.dart';

import 'item_row.dart';

class AdressRecive extends StatefulWidget {
  final OrderDetail orderDetail;

  const AdressRecive({Key? key, required this.orderDetail}) : super(key: key);

  @override
  State<AdressRecive> createState() => _AdressReciveState();
}

class _AdressReciveState extends State<AdressRecive> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        infoReciver(),
        const Divider(),
        infoOrder(),
        itemAmount(),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }

  Widget infoReciver() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.grey3, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemRow(
                    title: widget.orderDetail.customer_address ?? '',
                    value: '',
                    textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.black)),
                const SizedBox(
                  height: 6,
                ),
                   
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoOrder() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ItemRow(
              title: 'Thông tin đơn hàng',
              value: '',
              textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.black)),
          const SizedBox(height: 8),
          ItemRow(title: 'Mã đơn hàng', value: widget.orderDetail.code ?? ''),
          const SizedBox(height: 8),
          ItemRow(
              title: 'Trạng thái',
              value: widget.orderDetail.status?.label ?? '',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: HelperInfor.getColor(
                      widget.orderDetail.status?.value ?? ''))),
          const SizedBox(height: 8),
          ItemRow(
              title: 'Thời gian đặt',
              value: HelperInfor.getDate(widget.orderDetail.createdAt ?? '')),
          const SizedBox(height: 8),
          // ItemRow(
          //     title: 'Hình thức giao hàng',
          //     value: widget.orderDetail.customer_address ?? ''),
          const SizedBox(height: 8),
          // ItemRow(
          //     title: 'Hình thức thanh toán',
          //     value: widget.orderDetail.description ?? ''),
          const SizedBox(
            height: 16,
          ),
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
              value: '${widget.orderDetail.amount ?? ''} vnđ'),
          const SizedBox(
            height: 8,
          ),
          ItemRow(
              title: 'Phí vận chuyển',
              value: widget.orderDetail.shippingAmount ?? ''),
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
              value: '${widget.orderDetail.subTotal ?? ''} vnđ',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.color7F2B81)),
        ],
      ),
    );
  }
}
