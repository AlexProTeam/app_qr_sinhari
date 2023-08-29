import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/feature/news/details_news/bloc/bloc_details_news_bloc.dart';
import 'package:qrcode/feature/feature/news/history_model.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

Widget itemNews(NewsModel model, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RouteName.detailNewScreen,
          arguments: ArgumentDetailNewScreen(
              newsDetail: model.id, url: model.image));
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
                  Image.asset(
                    IconConst.miniClock,
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    model.createdAt ?? '',
                    style: AppTextTheme.smallGrey,
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