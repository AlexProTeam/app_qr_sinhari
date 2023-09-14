import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/bloc/profile_bloc/profile_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/product_model.dart';

import '../../app/di/injection.dart';
import '../../app/managers/color_manager.dart';
import '../../app/managers/const/icon_constant.dart';
import '../../app/route/format_utils.dart';
import '../../app/route/navigation/route_names.dart';
import '../feature/detail_product/detail_product_screen.dart';
import 'custom_image_network.dart';

///todo: use same a base item with home screen
class CategoryItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductResponse? productModel;
  final bool isShowLike;

  const CategoryItemProduct({
    Key? key,
    required this.itemWidth,
    this.productModel,
    this.isShowLike = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<ProfileBloc>().state.profileModel == null) {
          getIt<AppCache>().cacheProductId = productModel?.id;
        }
        Navigator.pushNamed(context, RouteDefine.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
              productId: productModel?.id,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageNetwork(
            url: '${productModel?.thumbnailImg}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 164,
            border: 12,
          ),
          const SizedBox(height: 16.25),
          SizedBox(
            height: 36,
            child: Text('${productModel?.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black)),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                IconConst.star,
                width: 13.5,
                height: 13,
              ),
              const SizedBox(width: 6),
              RichText(
                  text: const TextSpan(
                      text: '4.9 ',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                      children: [
                    TextSpan(
                      text: '(122 sản phẩm)',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.colorACACAC),
                    )
                  ]))
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatUtils.formatCurrencyDoubleToString(
                      productModel?.unitPrice),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorFFC700),
                ),
                const SizedBox(width: 5),
                RichText(
                  text: TextSpan(
                    text: FormatUtils.formatCurrencyDoubleToString(
                      productModel?.purchasePrice,
                    ),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorACACAC,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.colorACACAC,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (isShowLike)
                  Image.asset(
                    IconConst.heart,
                    width: 22,
                    height: 20,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
