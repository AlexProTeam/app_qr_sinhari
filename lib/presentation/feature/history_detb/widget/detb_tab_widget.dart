import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/presentation/feature/history_detb/bloc/history_debt_bloc.dart';

import 'item_history_detb_widget.dart';

class DetbsTabWidget extends StatelessWidget {
  const DetbsTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        context.read<HistoryDebtBloc>().state.debtModel?.data?.debts ?? [];

    return ListView.builder(
      padding: EdgeInsets.all(16.r).copyWith(bottom: 80.h),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final dataItem = data[index];

        return itemDetbsWidget(
            check: true,
            date: dataItem.createdAt,
            price: dataItem.amount,
            code: dataItem.order?.code);
      },
      itemCount: 1,
    );
  }
}
