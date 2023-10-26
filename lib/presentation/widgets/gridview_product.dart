import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/domain/entity/product_model.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/style_manager.dart';
import '../../app/utils/screen_utils.dart';
import '../feature/profile/bloc/profile_bloc.dart';
import 'category_product_item.dart';

class GridViewDisplayProduct extends StatelessWidget {
  final int numberItem;
  final String label;
  final List<ProductResponse>? products;
  final bool notExpand;
  final Function()? onMore;

  const GridViewDisplayProduct({
    Key? key,
    this.numberItem = 2,
    required this.label,
    this.products,
    this.notExpand = false,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: AppColors.colorEF4948)),
            InkWell(
              onTap: onMore,
              child: Text(
                'Xem thêm',
                style: TextStyleManager.normalGrey,
              ),
            )
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount:
              notExpand ? min(products?.length ?? 0, 4) : products?.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.h,
            mainAxisSpacing: 12.w,
            childAspectRatio:
                context.read<ProfileBloc>().state.profileModel?.isAgency == true
                    ? 0.5
                    : 0.6,
          ),
          itemBuilder: (context, index) {
            return CategoryItemProduct(
              itemWidth: itemWidth,
              productModel: products?[index],
              isShowLike: false,
            );
          },
        ),
      ],
    );
  }
}
