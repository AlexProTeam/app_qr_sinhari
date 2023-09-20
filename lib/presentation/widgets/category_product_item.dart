import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/helper.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../app/di/injection.dart';
import '../../app/managers/color_manager.dart';
import '../../app/managers/const/icon_constant.dart';
import '../../app/route/format_utils.dart';
import '../../app/route/navigation/route_names.dart';
import '../app_bloc/profile_bloc/profile_bloc.dart';
import '../feature/detail_product/detail_product_screen.dart';
import 'custom_image_network.dart';

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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageNetwork(
                url: '${productModel?.thumbnailImg}',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
                height: 164,
                border: 12,
              ),
              const SizedBox(height: 16.25),
              SizedBox(
                // height: 36,
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
                      text: TextSpan(
                          text: (productModel?.rating ?? 0).toString(),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                          children: [
                        TextSpan(
                          text:
                              ' (${(productModel?.quantity ?? 0).toString()} sản phẩm)',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.colorACACAC),
                        )
                      ]))
                ],
              ),
              itemPrice(),
            ],
          ),
          if (isShowLike)
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => ToastManager.showToast(
                  context,
                  text: 'Chức năng đang phát triển',
                ),
                child: Image.asset(
                  IconConst.heart,
                  width: 22,
                  height: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget itemPrice() {
    if (Helper.getPrice(
            productModel?.unitPrice ?? 0, productModel?.purchasePrice ?? 0) ==
        false) {
      return Column(
        children: [
          const SizedBox(height: 5),
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
                    color: AppColors.colorFFC700,
                  ),
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
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatUtils.formatCurrencyDoubleToString(
                      productModel?.purchasePrice),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorFFC700),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
