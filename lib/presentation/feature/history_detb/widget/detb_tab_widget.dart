import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app.dart';
import '../../../../app/managers/route_names.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../domain/entity/history_debt_model.dart';
import 'item_history_detb_widget.dart';

class DetbsTabWidget extends StatelessWidget {
  final List<Debts> debts;

  const DetbsTabWidget({Key? key, required this.debts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (debts.isEmpty) {
      Text(
        'Chưa có lịch sử nào',
        style: TextStyleManager.medium,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.r).copyWith(bottom: 100.h),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final dataItem = debts[index];

        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            Routes.instance.navigatorKey.currentContext!,
            RouteDefine.detailOrder,
            arguments: dataItem.orderId,
          ),
          child: itemDetbsWidget(
            context,
            isDebt: true,
            date: dataItem.createdAt,
            price: dataItem.amount,
            code: dataItem.order?.code,
            currency: dataItem.currency ?? '',
          ),
        );
      },
      itemCount: debts.length,
    );
  }
}
