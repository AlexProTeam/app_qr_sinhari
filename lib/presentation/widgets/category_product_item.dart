import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/route_names.dart';
import '../../app/utils/format_utils.dart';
import 'custom_image_network.dart';

class CategoryItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductResponse? productModel;
  final bool isShowLike;
  final bool isAgency;
  final Function()? onAddToCart;
  final Function()? buyNow;

  const CategoryItemProduct({
    Key? key,
    required this.itemWidth,
    this.productModel,
    this.isShowLike = true,
    this.isAgency = false,
    this.onAddToCart,
    this.buyNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width / 2,
                height: 150.h,
                border: 8.r,
              ),
              const Spacer(),
              SizedBox(
                child: Text('${productModel?.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Colors.black)),
              ),
              if (!isAgency) ...[
                const Spacer(),
                _buildRatingWidget(),
              ],
              const Spacer(),
              itemPriceProduct(
                salePrice: isAgency
                    ? productModel?.salePrice ?? 0
                    : productModel?.unitPrice ?? 0,
                price: isAgency
                    ? productModel?.price ?? 0
                    : productModel?.purchasePrice ?? 0,
              ),
              if (isAgency) ...[
                const Spacer(),
                _addToCartButton(),
                const Spacer(),
                _buyNowButton(),
                const Spacer(flex: 2),
              ],
            ],
          ),
          buildLikeIcon(context),
        ],
      ),
    );
  }

  Widget _addToCartButton() => CustomButton(
        height: 28.h,
        radius: 5.r,
        onTap: () {
          onAddToCart?.call();
        },
        text: 'Thêm vào giỏ',
        styleTitle: TextStyleManager.normalWhite.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      );

  Widget _buyNowButton() => CustomButton(
        height: 28.h,
        radius: 5.r,
        backGroupColor: AppColors.color003DB4,
        onTap: () {
          buyNow?.call();
        },
        text: 'Mua ngay',
        styleTitle: TextStyleManager.normalWhite.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      );

  Widget _buildRatingWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Assets.icons.star.image(
            width: 20.r,
            height: 20.r,
          ),
          6.verticalSpace,
          RichText(
              text: TextSpan(
                  text: (productModel?.rating ?? 0).toString(),
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                  children: [
                TextSpan(
                  text:
                      ' (${(productModel?.quantity ?? 0).toString()} sản phẩm)',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.colorACACAC),
                )
              ]))
        ],
      );

  Widget buildLikeIcon(BuildContext context) => isShowLike
      ? Positioned(
          bottom: 2.h,
          right: 5.w,
          child: GestureDetector(
            onTap: () => ToastManager.showToast(
              context,
              text: 'Chức năng đang phát triển',
            ),
            child: Assets.icons.heart.image(
              width: 22.r,
              height: 20.r,
            ),
          ),
        )
      : const SizedBox.shrink();
}

///todo: move this widget to common
Widget itemPriceProduct({required int salePrice, required int price}) {
  if (salePrice == price || salePrice == 0) {
    return Text(
      FormatUtils.formatCurrencyDoubleToString(price),
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.colorFFC700),
    );
  }

  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            FormatUtils.formatCurrencyDoubleToString(salePrice),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.colorFFC700,
            ),
          ),
          5.horizontalSpace,
          RichText(
            text: TextSpan(
              text: FormatUtils.formatCurrencyDoubleToString(
                price,
              ),
              style: TextStyle(
                fontSize: 10.sp,
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
    ],
  );
}
