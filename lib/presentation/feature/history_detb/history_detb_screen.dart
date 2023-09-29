import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';

class HistoryDetbScreen extends StatefulWidget {
  const HistoryDetbScreen({Key? key}) : super(key: key);

  @override
  State<HistoryDetbScreen> createState() => _HistoryDetbScreenState();
}

class _HistoryDetbScreenState extends State<HistoryDetbScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color0A55BA,
        title: Center(
          child: Text(
            'Lịch sử công nợ',
            style: TextStyleManager.medium,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return itemView();
              },
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemView() {
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
}
