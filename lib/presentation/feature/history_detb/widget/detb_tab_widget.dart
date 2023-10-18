import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_history_detb_widget.dart';

class DetbsTabWidget extends StatelessWidget {
  const DetbsTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.r).copyWith(bottom: 80.h),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return itemDetbsWidget();
      },
      itemCount: 1,
    );
  }
}
