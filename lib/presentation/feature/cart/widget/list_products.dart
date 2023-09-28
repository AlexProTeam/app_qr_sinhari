import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/widgets/check_box_custom.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const ItemList();
      },
      itemCount: 2,
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.colorF1F1F1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 30,
              height: 30,
              child: CheckBoxCustom(
                enable: true,
                onChanged: (_) {},
              )),
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
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'vệ sinh thảo dược Doctor Care',
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
                              color: AppColors.color7F2B81),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Số lượng: ',
                        style: TextStyleManager.mediumBlack14px.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemCircle(
                                path: Assets.icons.iconDown.path,
                                onTap: () {},
                                color: AppColors.color777777),
                            Text(
                              '1',
                              style: TextStyleManager.mediumBlack14px.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            itemCircle(
                                path: Assets.icons.icPlus.path,
                                onTap: () {},
                                color: AppColors.color7F2B81)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemCircle(
      {required String path, required Function onTap, Color? color}) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color ?? AppColors.red),
          child: Image.asset(path),
        ));
  }
}
