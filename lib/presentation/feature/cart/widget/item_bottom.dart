import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/widgets/check_box_custom.dart';

class ItemBottom extends StatelessWidget {
  final Function onTap;
  final Function onChange;

  const ItemBottom({Key? key, required this.onTap, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      height: 130,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 100,
                  height: 30,
                  child: CheckBoxCustom(
                    enable: true,
                    title: 'Chọn tất cả',
                    onChanged: (_) {
                      onChange();
                    },
                  )),
              Column(
                children: [
                  Text(
                    'Tổng thanh toán',
                    style: TextStyleManager.mediumBlack14px
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    '240.000 vnđ',
                    style: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.red),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.red,
                ),
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 16, top: 16),
                child: Text(
                  'Mua hàng',
                  style: TextStyleManager.mediumBlack14px.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
