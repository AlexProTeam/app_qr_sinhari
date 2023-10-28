import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/num_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/widgets/check_box_custom.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';

import '../bloc/carts_bloc.dart';

class ItemBottomCarts extends StatefulWidget {
  final Function onTap;

  const ItemBottomCarts({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ItemBottomCarts> createState() => _ItemBottomCartsState();
}

class _ItemBottomCartsState extends State<ItemBottomCarts> {
  late CartsBloc _cartsBloc;

  @override
  void initState() {
    _cartsBloc = context.read<CartsBloc>();
    super.initState();
  }

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
      height: 120.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 100.w,
                  height: 30.h,
                  child: CheckBoxCustom(
                    enable: true,
                    title: 'Chọn tất cả',
                    onChanged: (value) =>
                        _cartsBloc.add(const SelectedAllItemEvent()),
                    value: _cartsBloc.state.isSelectedAll,
                  )),
              Column(
                children: [
                  Text(
                    'Tổng thanh toán',
                    style: TextStyleManager.mediumBlack14px.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    '${_cartsBloc.state.cartsResponse?.carts?.getTotalPriceQty.toAppNumberFormat} vnđ',
                    style: TextStyleManager.mediumBlack14px.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: AppColors.red,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              )
            ],
          ),
          8.verticalSpace,
          CustomButton(
            backGroupColor:
                _cartsBloc.state.isSelectedAny ? null : AppColors.grey7,
            width: (MediaQuery.of(context).size.width - 32).w,
            radius: 8.r,
            text: 'Mua hàng',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
