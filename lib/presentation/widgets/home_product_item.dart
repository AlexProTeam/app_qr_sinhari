import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/product_model.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../app/managers/color_manager.dart';
import '../../app/route/navigation/route_names.dart';
import 'category_product_item.dart';
import 'custom_image_network.dart';

class ProductItemHome extends StatelessWidget {
  const ProductItemHome(
      {Key? key, required this.productModel, this.isAgency = false})
      : super(key: key);
  final ProductResponse? productModel;
  final bool isAgency;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      height: 120.h,
      decoration: BoxDecoration(
        boxShadow: AppConstant.defaultShadow,
        color: AppColors.bgrScafold,
        borderRadius: BorderRadius.all(
          Radius.circular(
            6.r,
          ),
        ),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              RouteDefine.detailProductScreen,
              arguments: ArgumentDetailProductScreen(
                productId: productModel?.id,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: CustomImageNetwork(
                    url: '${productModel?.thumbnailImg}',
                    fit: BoxFit.cover,
                    width: 110.w,
                    height: 110.h,
                    border: 6.r,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productModel?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Colors.black,
                            height: 1.3,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Assets.icons.star.image(
                              width: 16.r,
                              height: 16.r,
                            ),
                            6.horizontalSpace,
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
                                        ' (${(productModel?.quantity ?? 0).toString()} Sản phẩm)',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.colorACACAC),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        itemPriceProduct(
                          salePrice: isAgency
                              ? productModel?.salePrice ?? 0
                              : productModel?.unitPrice ?? 0,
                          price: isAgency
                              ? productModel?.price ?? 0
                              : productModel?.purchasePrice ?? 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5.h,
            right: 5.w,
            child: GestureDetector(
              onTap: () => ToastManager.showToast(
                context,
                text: 'Chức năng đang phát triển',
              ),
              child: Assets.icons.heart.image(
                width: 20.r,
                height: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
