import 'package:flutter/material.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

import 'widget/item_bottom.dart';
import 'widget/item_check_promotion.dart';
import 'widget/item_total_amount.dart';
import 'widget/list_products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Giỏ hàng',
        isShowBack: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: const [
            ListProducts(),
            ItemCheckPromotion(),
            Divider(),
            ItemTotalAmount()
          ],
        ),
      ),
      bottomNavigationBar: ItemBottom(
        onTap: () {
          DialogManager.showDialogCustom(
              icon: Image.asset(Assets.icons.icQuesition.path),
              onTapRight: () {},
              onTapLeft: () {
                Navigator.pushNamed(
                    Routes.instance.navigatorKey.currentContext!,
                    RouteDefine.successScreen);
              },
              leftTitle: 'Mua',
              rightTitle: 'Huỷ',
              context: context,
              bgColorLeft: AppColors.realEstate,
              bgColorRight: AppColors.red,
              content: 'Bạn có chắc hoàn thành đơn hàng ?',
              styleContent: kTextRegularStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 20));
        },
        onChange: () {},
      ),
    );
  }
}
