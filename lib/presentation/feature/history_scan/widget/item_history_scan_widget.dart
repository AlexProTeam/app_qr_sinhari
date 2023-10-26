import 'package:flutter/material.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';

import '../../../../app/managers/route_names.dart';
import '../../../../app/managers/style_manager.dart';
import '../../../widgets/custom_image_network.dart';
import '../history_model.dart';

Widget itemHistoryScan(BuildContext context, HistoryModel model) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RouteDefine.detailProductScreen,
          arguments: ArgumentDetailProductScreen(
            productId: model.productId,
            url: model.urlScan,
          ));
    },
    child: SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageNetwork(
            url: model.image,
            width: 80,
            height: 80,
            border: 5,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                style: TextStyleManager.smallGrey,
              ),
              const SizedBox(height: 5),
              Text(
                'Số Seri: ${model.numberSeri ?? ''}',
                style: TextStyleManager.smallGrey,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
