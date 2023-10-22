import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../app/route/navigation/route_names.dart';
import '../../../app/route/screen_utils.dart';
import '../../widgets/category_product_item.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/qty_carts_widget.dart';
import '../../widgets/toast_manager.dart';
import '../detail_product/bloc/product_detail_bloc.dart';
import '../detail_product/ui/detail_product_screen.dart';
import 'bloc/list_product_bloc.dart';

class ArgumentListProductScreen {
  final String? url;
  final String? label;
  final bool isAgency;

  ArgumentListProductScreen({this.url, this.label, this.isAgency = false});
}

class ListProductScreen extends StatefulWidget {
  final ArgumentListProductScreen? argument;

  const ListProductScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  ListProductScreenState createState() => ListProductScreenState();
}

class ListProductScreenState extends State<ListProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '${widget.argument?.label}',
        isShowBack: true,
        actions: [
          if (widget.argument?.isAgency ?? false)
            InkWell(
              onTap: () => Navigator.pushNamed(
                Routes.instance.navigatorKey.currentContext!,
                RouteDefine.cartScreen,
              ),
              child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
                listener: (context, state) {
                  state.status == BlocStatusEnum.loading
                      ? DialogManager.showLoadingDialog(context)
                      : DialogManager.hideLoadingDialog;

                  if (state.isNavigateToCartScreen &&
                      widget.argument?.isAgency == true) {
                    Navigator.pushNamed(
                      Routes.instance.navigatorKey.currentContext!,
                      RouteDefine.cartScreen,
                      arguments: ArgumentCartScreen(
                        carts: state.addToCartModel?.carts,
                      ),
                    );
                  }

                  if (state.errMes.isNotEmpty) {
                    ToastManager.showToast(
                      context,
                      text: state.errMes,
                    );
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Stack(
                        children: [
                          Assets.icons.icCar.image(
                            width: 25.r,
                            height: 25.r,
                          ),
                          qtyCartsWidget(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
        ],
      ),
      body: BlocBuilder<ListProductBloc, ListProductState>(
        builder: (BuildContext context, state) {
          final products = state.products ?? [];
          if (state.status == BlocStatusEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (products.isEmpty) {
            return const Center(
              child: Text("Không có sản phẩm nào!"),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h)
                .copyWith(bottom: 100.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.h,
              mainAxisSpacing: 12.w,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              final data = products[index];

              return CategoryItemProduct(
                isShowLike: false,
                itemWidth: (GScreenUtil.screenWidthDp - 48) / 2,
                productModel: products[index],
                isAgency: widget.argument?.isAgency == true,
                onAddToCart: () => addToCartScreen(id: data.id ?? 0),
                buyNow: () => addToCartScreen(
                  id: data.id ?? 0,
                  isAddToCartOnly: false,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void addToCartScreen({
    int? id,
    bool isAddToCartOnly = true,
  }) =>
      context.read<ProductDetailBloc>().add(
            OnAddToCartEvent(
              proId: id ?? 0,
              isAddToCartOnly: isAddToCartOnly,
            ),
          );
}
