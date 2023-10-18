import 'package:flutter/material.dart';
import 'package:qrcode/domain/entity/noti_model.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../widgets/custom_image_network.dart';

Widget itemNotification(NotiResponse model) => Container(
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
                      model.createdAt ?? '',
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
    );
