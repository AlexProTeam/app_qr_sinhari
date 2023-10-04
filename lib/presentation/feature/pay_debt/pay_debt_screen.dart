import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/input_custom.dart';

class PayDebt extends StatefulWidget {
  const PayDebt({Key? key}) : super(key: key);

  @override
  State<PayDebt> createState() => _PayDebtState();
}

class _PayDebtState extends State<PayDebt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thanh toán Công nợ',
        isShowBack: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MBPTextField(
              title: 'Nhập số tiền thanh toán',
              isRequired: true,
              onChanged: (_) {},
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteDefine.payDebtQrScreen);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.red,
              ),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 16, top: 16),
              child: Text(
                'Gửi thanh toán',
                style: TextStyleManager.mediumBlack14px.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
