import 'package:flutter/material.dart';

import '../../../../common/const/string_const.dart';
import '../../../../common/navigation/route_names.dart';
import '../../../themes/theme_text.dart';
import '../../../widgets/custom_image_network.dart';
import '../../news/detail_new_screen.dart';
import '../../news/history_model.dart';

class ItemNews extends StatelessWidget {
  final NewsModel model;

  const ItemNews({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteName.detailNewScreen,
          arguments:
              ArgumentDetailNewScreen(newsDetail: model.id, url: model.image)),
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            boxShadow: StringConst.defaultShadow,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNetwork(
              url: model.image,
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
              border: 12,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                model.title ?? '',
                style: AppTextTheme.normalRoboto,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                model.createdAt ?? '',
                style: AppTextTheme.smallGrey,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
