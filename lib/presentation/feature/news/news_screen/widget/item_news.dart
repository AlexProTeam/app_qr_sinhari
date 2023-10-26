import 'package:flutter/material.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../../../app/managers/route_names.dart';
import '../../../../../app/managers/style_manager.dart';
import '../../../../widgets/custom_image_network.dart';
import '../../details_news/ui/detail_new_screen.dart';
import '../../history_model.dart';

Widget itemNews(NewsModelResponse model, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RouteDefine.detailNewScreen,
          arguments:
              ArgumentDetailNewScreen(newsDetail: model.id, url: model.image));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageNetwork(
          url: model.image,
          width: 164,
          height: 164,
          fit: BoxFit.cover,
          border: 12,
        ),
        const SizedBox(
          height: 16.45,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Assets.icons.miniClock.image(
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    model.createdAt ?? '',
                    style: TextStyleManager.smallGrey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
