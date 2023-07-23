import 'package:flutter/material.dart';
import 'package:qrcode/common/navigation/route_names.dart';

import '../../themes/theme_text.dart';
import '../../widgets/custom_image_network.dart';
import '../detail_product/detail_product_screen.dart';
import 'history_model.dart';

Widget itemHistoryScan(BuildContext context, HistoryModel model) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RouteName.detailProductScreen,
          arguments: ArgumentDetailProductScreen(
            productId: model.productId,
            url: model.urlScan,
          ));
    },
    child: SizedBox(
      height: 74,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageNetwork(
            url: model.image,
            width: 74,
            height: 74,
            border: 5,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        model.productName ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      model.count ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0085FF),
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Mã Code: ${model.code ?? ''}',
                style: AppTextTheme.smallGrey,
              ),
              const SizedBox(height: 5),
              Text(
                'Số Seri: ${model.numberSeri ?? ''}',
                style: AppTextTheme.smallGrey,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
