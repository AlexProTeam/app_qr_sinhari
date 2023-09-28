import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/presentation/widgets/input_custom.dart';

class ItemCheckPromotion extends StatelessWidget {
  const ItemCheckPromotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã khuyến mại',
            style: TextStyleManager.mediumBlack14px
                .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 132,
                child: MBPTextField(
                  contentPadding:
                      const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  boderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                  borderColor: kSurfaceDisabledColor,
                  hint: 'Nhập mã khuyến mại',
                  textStyle: TextStyleManager.mediumBlack14px.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.red),
                  onChanged: (_) {},
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.red),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    color: AppColors.red,
                  ),
                  padding: const EdgeInsets.only(top: 14, bottom: 16),
                  child: Text(
                    'Kiểm tra',
                    style: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
