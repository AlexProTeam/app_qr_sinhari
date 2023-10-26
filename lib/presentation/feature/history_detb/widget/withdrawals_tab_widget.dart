import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/managers/style_manager.dart';
import '../../../../domain/entity/history_debt_model.dart';
import 'item_history_detb_widget.dart';

class WithdrawalsTabWidget extends StatelessWidget {
  final List<Withdrawals> withdrawals;

  const WithdrawalsTabWidget({
    Key? key,
    required this.withdrawals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (withdrawals.isEmpty) {
      Text(
        'Chưa có lịch sử nào',
        style: TextStyleManager.medium,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.r).copyWith(bottom: 100.h),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final dataItem = withdrawals[index];
        return itemDetbsWidget(
          context,
          code: dataItem.status?.label,
          isDebt: false,
          date: dataItem.createdAt,
          price: dataItem.amount,
          currency: dataItem.currency ?? '',
        );
      },
      itemCount: withdrawals.length,
    );
  }
}
