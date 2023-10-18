import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/string_ex.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../infomation_customer/widget/infor_enum.dart';

Widget itemDetbsWidget(
  BuildContext context, {
  String? date,
  String? price,
  String? code,
  required bool isDebt,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
        color: AppColors.grey3,
        border: Border.all(width: 1, color: AppColors.color95B9EE),
        borderRadius: BorderRadius.circular(8.r)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          HelperInfor.getDate(date ?? ''),
          style: TextStyleManager.mediumBlack.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 13.sp,
          ),
        ),
        4.verticalSpace,
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Sinhair',
                  style: TextStyleManager.mediumBlack,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' xin thông báo tới quý khách:',
                        style: TextStyleManager.normalBlack),
                  ],
                ),
              ),
              4.verticalSpace,
              Text(
                'Tài khoản: ${context.read<ProfileBloc>().state.profileModel?.name}',
                style: TextStyleManager.normalBlack,
              ),
              4.verticalSpace,
              Text(
                '${isDebt ? '-' : '+'}${price.toAppNumberFormatWithNull}',
                style: TextStyleManager.normalBlack.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDebt ? Colors.red : Colors.green,
                ),
              ),
              4.verticalSpace,
              RichText(
                text: TextSpan(
                  text: isDebt
                      ? 'Đã mua đơn hàng số ${code ?? ''}'
                      : 'Trạng thái: ${code ?? ''}',
                  style: TextStyleManager.normalBlack,
                  children: <TextSpan>[
                    TextSpan(
                      text: isDebt ? ' Chi tiết đơn hàng' : '',
                      style: TextStyleManager.normalBlack.copyWith(
                        color: AppColors.color064CFC,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
