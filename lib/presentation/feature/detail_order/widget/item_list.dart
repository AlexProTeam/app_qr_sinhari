import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.colorF1F1F1))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              Assets.images.welcome.path,
              width: 111,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sản phẩm số 1',
                    style: TextStyleManager.mediumBlack14px
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '120.000 vnđ',
                          style: TextStyleManager.mediumBlack14px.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.color7F2B81,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Sản phẩm số 1',
                          style: TextStyleManager.mediumBlack14px.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Số lượng: 1',
                    style: TextStyleManager.mediumBlack14px
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
