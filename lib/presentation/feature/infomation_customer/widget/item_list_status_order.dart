import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';

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
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            'Đơn hàng của tôi',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  StatusEnum.values.length,
                  (index) => item(
                      image: StatusEnum.values[index].getIcon(),
                      name: StatusEnum.values[index].getName(),
                      onTap: StatusEnum.values[index].getOnTap())),
            )),
      ],
    );
  }

  Widget item(
      {required String? image,
      required String? name,
      required Function onTap}) {
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

enum StatusEnum { wait, shiping, complete, cancel }

extension ItemEx on StatusEnum {
  Function() getOnTap() {
    switch (this) {
      case StatusEnum.wait:
        return () {};
      case StatusEnum.shiping:
        return () {};
      case StatusEnum.complete:
        return () {};
      case StatusEnum.cancel:
        return () {};
    }
  }

  String getName() {
    switch (this) {
      case StatusEnum.wait:
        return 'Đang chờ';
      case StatusEnum.shiping:
        return 'Đang giao';
      case StatusEnum.complete:
        return 'Hoàn thành';
      case StatusEnum.cancel:
        return 'Đã huỷ';
    }
  }

  String getIcon() {
    switch (this) {
      case StatusEnum.wait:
        return Assets.icons.iconWait.path;
      case StatusEnum.shiping:
        return Assets.icons.iconTruck.path;
      case StatusEnum.complete:
        return Assets.icons.iconComplete.path;
      case StatusEnum.cancel:
        return Assets.icons.iconTimeLine.path;
    }
  }
}
