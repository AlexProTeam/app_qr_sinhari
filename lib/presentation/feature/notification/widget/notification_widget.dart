import 'package:flutter/material.dart';
import 'package:qrcode/domain/entity/noti_model.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/route_names.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../../domain/all_app_enum/noti_enum_type.dart';
import '../../../widgets/custom_image_network.dart';
import '../../detail_product/ui/detail_product_screen.dart';

Widget itemNotification(BuildContext context, NotiResponse model) => InkWell(
      onTap: () {
        switch (model.postType) {
          case PostTypeEnum.notification:
            if (model.content != null) {
              Navigator.pushNamed(
                context,
                RouteDefine.webViewDetailScreen,
                arguments: model.content ?? '',
              );
            }
            break;
          case PostTypeEnum.product:
            Navigator.pushNamed(context, RouteDefine.detailProductScreen,
                arguments: ArgumentDetailProductScreen(
                  productId: model.productId,
                ));
            return;
          case PostTypeEnum.order:
            Navigator.pushReplacementNamed(
              context,
              RouteDefine.detailOrder,
              arguments: model.orderId,
            );
            break;
          case PostTypeEnum.debts:
            Navigator.pushReplacementNamed(
              context,
              RouteDefine.historyDetb,
            );
            break;
          default:
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.colorF4F5FB,
          border: Border(
            bottom: BorderSide(color: AppColors.grey4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageNetwork(
                url: model.image,
                width: 16,
                height: 16,
                fit: BoxFit.cover,
                border: 4,
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          model.title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        model.getCreatedAt,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: AppColors.colorACACAC),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    model.des ?? '',
                    style: TextStyleManager.normalBlack,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
