import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../app/managers/status_bloc.dart';
import '../../../app/route/navigation/route_names.dart';
import '../../../domain/entity/list_carts_response.dart';
import 'bloc/carts_bloc.dart';
import 'widget/item_bottom.dart';
import 'widget/item_check_promotion.dart';
import 'widget/item_total_amount.dart';
import 'widget/list_products.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartsBloc, CartsState>(
      listenWhen: (previous, current) => previous != current,
      buildWhen: (previous, current) =>
          previous.cartsResponse != current.cartsResponse,
      listener: (context, state) async {
        state.status == BlocStatusEnum.loading
            ? DialogManager.showLoadingDialog(context)
            : DialogManager.hideLoadingDialog;

        if ((state.errMes ?? '').isNotEmpty) {
          ToastManager.showToast(context, text: state.errMes!);
        }

        if ((state.confirmCartResponse?.orderDetail?.code ?? '').isNotEmpty) {
          Navigator.pushReplacementNamed(
            context,
            RouteDefine.successScreen,
            arguments: state.confirmCartResponse?.orderDetail,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar(
            title: 'Giỏ hàng',
            backGroundColor: AppColors.color7F2B81,
            isShowBack: true,
            titleColor: AppColors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// list item
                ListProducts(
                  listItemsCarts: state.cartsResponse?.carts?.items ?? [],
                ),

                /// nhập khuyến mãi
                const ItemCheckPromotion(),
                const Divider(),

                /// thống kê sản phẩm
                ItemTotalAmount(
                  listCartsResponse: state.cartsResponse ?? ListCartsResponse(),
                )
              ],
            ),
          ),

          /// bottom mua hàng
          bottomNavigationBar: ItemBottomCarts(
            onTap: () => DialogManager.showDialogConfirm(
              context,
              content: 'Bạn có chắc hoàn thành đơn hàng ?',
              leftTitle: 'Mua',
              onTapLeft: () {
                if ((state.cartsResponse?.carts?.items ?? []).isNotEmpty) {
                  context.read<CartsBloc>().add(const ConfirmCartEvent());
                }
              },
            ),
          ),
        );
      },
    );
  }
}
