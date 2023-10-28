import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../app/managers/route_names.dart';
import '../../../app/managers/status_bloc.dart';
import '../../../app/managers/style_manager.dart';
import '../../../domain/entity/list_carts_response.dart';
import '../address/bloc/address_bloc.dart';
import '../address/widget/address_item_widget.dart';
import 'bloc/carts_bloc.dart';
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
  void initState() {
    context.read<AddressBloc>().add(GetListAddressEvent());
    super.initState();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.verticalSpace,

                /// địa chỉ
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Địa chỉ nhận hàng',
                    style: TextStyleManager.normalBlack.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: BlocBuilder<AddressBloc, AddressState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      final dataDefault = state.defaultAddress;

                      return AddressItemWidget(
                        fullName: dataDefault.name ?? '',
                        phoneNumber: dataDefault.phone ?? '',
                        address: dataDefault.address ?? '',
                        note: dataDefault.note ?? '',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteDefine.addressScreen,
                          );
                        },
                      );
                    },
                  ),
                ),
                10.verticalSpace,
                const Divider(),

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
            onTap: () {
              if (state.isSelectedAny) {
                DialogManager.showDialogConfirm(
                  context,
                  content: 'Bạn có chắc hoàn thành đơn hàng ?',
                  leftTitle: 'Mua',
                  onTapLeft: () => context.read<CartsBloc>().add(
                        ConfirmCartEvent(
                            addressId: context
                                    .read<AddressBloc>()
                                    .state
                                    .defaultAddress
                                    .id ??
                                0),
                      ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
