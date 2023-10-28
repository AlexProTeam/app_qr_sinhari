import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../gen/assets.gen.dart';

class AddressItemWidget extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final String address;
  final String note;
  final Function() onTap;
  final Function()? onTapDelete;

  const AddressItemWidget({
    Key? key,
    this.fullName = '',
    this.phoneNumber = '',
    this.address = '',
    this.note = '',
    required this.onTap,
    this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Center(
                    child: Assets.icons.location.image(
                      width: 25.w,
                      height: 27.h,
                      color: AppColors.color7F2B81,
                    ),
                  ),
                  5.horizontalSpace,
                  Expanded(
                    child: Text(
                      '$fullName | $phoneNumber',
                      style: TextStyleManager.normalBlack,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  'Địa chỉ: $address',
                  style: TextStyleManager.normalBlack,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              3.verticalSpace,
              Text(
                'Lưu ý: $note',
                style: TextStyleManager.normalBlack,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          if (onTapDelete != null)
            Positioned(
              top: 0,
              right: 5.w,
              child: InkWell(
                onTap: onTapDelete,
                child: Icon(
                  Icons.delete_forever,
                  color: AppColors.red,
                  size: 18.sp,
                ),
              ),
            ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 5.w,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.color7F2B81,
            ),
          ),
        ],
      ),
    );
  }
}
