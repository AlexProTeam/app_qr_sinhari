import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';

import 'item_row.dart';

class AdressRecive extends StatefulWidget {
  const AdressRecive({Key? key}) : super(key: key);

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
                    title: 'Hoang Huy',
                    value: '',
                    textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.black)),
                const SizedBox(
                  height: 6,
                ),
                ItemRow(
                    title: '0966 123 456',
                    value: '',
                    textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.color777777)),
                const SizedBox(
                  height: 6,
                ),
                ItemRow(
                    title: 'Hà Nội - Thanh Xuân',
                    value: '',
                    textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.color777777)),
                const SizedBox(
                  height: 6,
                ),
                ItemRow(
                    title: 'Số 123 Nguyễn Trãi',
                    value: '',
                    textStyleTitle: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.color777777)),
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
          const ItemRow(title: 'Mã đơn hàng', value: '12345678'),
          const SizedBox(height: 8),
          ItemRow(
              title: 'Trạng thái',
              value: 'Hoàn thành',
              textStyleValue: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.green)),
          const SizedBox(height: 8),
          const ItemRow(title: 'Thời gian đặt', value: '08:00 - 01/12/2021'),
          const SizedBox(height: 8),
          const ItemRow(
              title: 'Hình thức giao hàng', value: 'Giao hàng tiêu chuẩn'),
          const SizedBox(height: 8),
          const ItemRow(
              title: 'Hình thức thanh toán', value: 'Thanh toán khi nhận hàng'),
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
          const ItemRow(title: 'Tổng tiền', value: '200.000 vnđ'),
          const SizedBox(
            height: 8,
          ),
          const ItemRow(title: 'Phí vận chuyển', value: '200.000 vnđ'),
          const SizedBox(
            height: 8,
          ),
          const ItemRow(title: 'Mã khuyến mại', value: '200.000 vnđ'),
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
