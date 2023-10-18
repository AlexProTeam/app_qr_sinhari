import 'package:flutter/material.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';

Widget itemDetbsWidget() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: AppColors.grey3,
        border: Border.all(width: 1, color: AppColors.color95B9EE),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '29/08/2023 21:00',
          style: TextStyleManager.mediumBlack,
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Sinhair',
                  style: TextStyleManager.mediumBlack,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' xin thông báo tới quý khách:',
                        style: TextStyleManager.normalBlack),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Tài khoản: Ngô Long',
                style: TextStyleManager.normalBlack,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '- 5.000.000 VNĐ',
                style: TextStyleManager.normalBlack,
              ),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: TextSpan(
                  text: 'Đã mua đơn hàng số #xxx',
                  style: TextStyleManager.normalBlack,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' xin thông báo tới quý khách:',
                        style: TextStyleManager.normalBlack
                            .copyWith(color: AppColors.color064CFC)),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
