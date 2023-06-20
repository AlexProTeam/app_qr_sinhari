import 'package:flutter/material.dart';

import '../../../../common/const/string_const.dart';
import '../../../../common/navigation/route_names.dart';
import '../../../../common/utils/screen_utils.dart';
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
      onTap: () {
        Navigator.pushNamed(context, RouteName.detailNewScreen,
            arguments: ArgumentDetailNewScreen(
                newsDetail: model.id, url: model.image));
      },
      child: Container(
        width: GScreenUtil.screenWidthDp * 0.6,
        margin: const EdgeInsets.symmetric(vertical: 12).copyWith(right: 16),
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
              height: MediaQuery.of(context).size.height * 0.15,
              fit: BoxFit.cover,
              border: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? '',
                    style: AppTextTheme.normalRoboto,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    model.createdAt ?? '',
                    style: AppTextTheme.smallGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
