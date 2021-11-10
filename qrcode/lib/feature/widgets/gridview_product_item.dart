import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

class CategoryDetailWidgetItemProduct extends StatelessWidget {
  final double itemWidth;

  const CategoryDetailWidgetItemProduct({
    Key? key,
    required this.itemWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sizeImage = itemWidth - 10;
    return InkWell(
      onTap: () {
        Routes.instance.navigateTo(RouteName.DetailProductScreen);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
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
              url:
                  'https://product.hstatic.net/200000192975/product/9_5ca9ca693ec04b15b7f08dc72b33fa92_master.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: _sizeImage,
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Text(
                    '(Sin hair) Dầu gội màu nâu',
                    overflow: TextOverflow.ellipsis,
                    style:
                        AppTextTheme.smallGrey.copyWith(color: AppColors.black),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '350.000 đ',
                        style: AppTextTheme.normalPrimary,
                      ),
                      const Spacer(),
                      Image.asset(
                        IconConst.fakeStar,
                        width: 80,
                        height: 15,
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
