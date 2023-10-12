import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/infomation_customer/bloc/info_bloc.dart';

class ItemListStatusOrder extends StatefulWidget {
  const ItemListStatusOrder({Key? key}) : super(key: key);

  @override
  State<ItemListStatusOrder> createState() => _ItemListStatusOrderState();
}

class _ItemListStatusOrderState extends State<ItemListStatusOrder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 20.w),
          child: const Text(
            'Đơn hàng của tôi',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 100.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              StatusOrderHistoryEnum.values.length,
              (index) => item(
                image: StatusOrderHistoryEnum.values[index].getIcon(),
                name: StatusOrderHistoryEnum.values[index].getName(),
                onTap: () => context.read<InfoBloc>().add(InitListProductEvent(
                    status: StatusOrderHistoryEnum.values[index].getEnumKey)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget item({
    required String? image,
    required String? name,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Image.asset(
              image ?? '',
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              name ?? '',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum StatusOrderHistoryEnum { wait, shiping, complete, cancel }

extension ItemEx on StatusOrderHistoryEnum {
  String get getEnumKey {
    switch (this) {
      case StatusOrderHistoryEnum.wait:
        return 'pending';

      case StatusOrderHistoryEnum.shiping:
        return 'processing';

      case StatusOrderHistoryEnum.complete:
        return 'completed';

      case StatusOrderHistoryEnum.cancel:
        return 'canceled';
    }
  }

  String getName() {
    switch (this) {
      case StatusOrderHistoryEnum.wait:
        return 'Đang chờ';
      case StatusOrderHistoryEnum.shiping:
        return 'Đang giao';
      case StatusOrderHistoryEnum.complete:
        return 'Hoàn thành';
      case StatusOrderHistoryEnum.cancel:
        return 'Đã huỷ';
    }
  }

  String getIcon() {
    switch (this) {
      case StatusOrderHistoryEnum.wait:
        return Assets.icons.iconWait.path;
      case StatusOrderHistoryEnum.shiping:
        return Assets.icons.iconTruck.path;
      case StatusOrderHistoryEnum.complete:
        return Assets.icons.iconComplete.path;
      case StatusOrderHistoryEnum.cancel:
        return Assets.icons.iconTimeLine.path;
    }
  }
}
