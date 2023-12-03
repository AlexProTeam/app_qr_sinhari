import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/core/num_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/route_names.dart';
import 'package:qrcode/domain/entity/profile_model.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import '../../../widgets/custom_image_network.dart';

class ItemHeaderProfileBill extends StatelessWidget {
  const ItemHeaderProfileBill({Key? key}) : super(key: key);

  void _navigateToHistoryDebt(BuildContext context) {
    Navigator.pushNamed(context, RouteDefine.historyDetb);
  }

  void _navigateToPayDebt(BuildContext context) {
    Navigator.pushNamed(context, RouteDefine.payDebt);
  }

  Widget _buildDebtInfo(BuildContext context, ProfileModel profileData) {
    return GestureDetector(
      onTap: () => _navigateToHistoryDebt(context),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.color0A55BA,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(Assets.icons.iconBank.path),
            8.horizontalSpace,
            Text(
              (profileData.currentDebt ?? 0).toDouble().toAppNumberFormat,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: AppColors.color2604F5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCodeButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPayDebt(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.color0A55BA, width: 1),
        ),
        child: Image.asset(Assets.icons.iconQr.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileData =
        context.read<ProfileBloc>().state.profileModel ?? ProfileModel();

    return Column(
      children: [
        ClipOval(
          child: CustomImageNetwork(
            url: profileData.getAvatar,
            width: 80.r,
            height: 80.r,
            fit: BoxFit.cover,
          ),
        ),
        5.verticalSpace,
        Text(
          profileData.phone ?? '',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        5.verticalSpace,
        Text(
          profileData.name ?? '',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black.withOpacity(0.7),
          ),
        ),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDebtInfo(context, profileData),
            10.horizontalSpace,
            _buildQrCodeButton(context),
          ],
        ),
      ],
    );
  }
}
