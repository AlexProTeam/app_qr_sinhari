import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

class CategoryDetailWidgetItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductModel? productModel;

  const CategoryDetailWidgetItemProduct({
    Key? key,
    required this.itemWidth,
    this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sizeImage = itemWidth - 10;
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.DetailProductScreen,
            arguments: productModel?.id);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: '${productModel?.thumbnailImg}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: _sizeImage,
              border: 12,
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      '${productModel?.name}',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.smallGrey
                          .copyWith(color: AppColors.black),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                    width: double.infinity,
                    height: 38,
                  ),
                  Row(
                    children: [
                      Text(
                        '${FormatUtils.formatCurrencyDoubleToString(productModel?.purchasePrice ?? productModel?.unitPrice)}',
                        style: AppTextTheme.normalPrimary,
                      ),
                      const Spacer(),
                      Image.asset(
                        IconConst.fakeStar,
                        width: 60,
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
