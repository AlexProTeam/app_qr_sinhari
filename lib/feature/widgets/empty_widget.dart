import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final Function? onReload;
  const EmptyWidget({Key? key, this.onReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onReload != null) {
          onReload!();
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(onReload != null ? 'Tải lại' : 'Không có dữ liệu'),
        ),
      ),
    );
  }
}
