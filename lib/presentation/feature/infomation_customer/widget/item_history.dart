import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/core/string_ex.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/domain/entity/order_model.dart';
import 'package:qrcode/presentation/feature/infomation_customer/bloc/info_bloc.dart';
import 'package:qrcode/presentation/feature/infomation_customer/widget/infor_enum.dart';
import 'package:qrcode/presentation/widgets/custom_image_network.dart';

class ItemHistory extends StatelessWidget {
  const ItemHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoBloc, InfoState>(
      builder: (BuildContext context, state) {
        final products = state.products ?? [];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            children: [
              Text(
                'Lịch sử đơn hàng ',
                style: TextStyleManager.title.copyWith(
                  fontSize: 20.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              16.verticalSpace,
              if (state.status == BlocStatusEnum.loading)
                const Center(child: CircularProgressIndicator()),
              if (products.isEmpty && state.status != BlocStatusEnum.loading)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: const Text("Không có sản phẩm nào!"),
                  ),
                ),
              if (products.isNotEmpty && state.status != BlocStatusEnum.loading)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return rootView(
                        context: context,
                        onTap: () {
                          Navigator.pushNamed(
                              Routes.instance.navigatorKey.currentContext!,
                              RouteDefine.detailOrder,
                              arguments: products[index].id);
                        },
                        order: products[index]);
                  },
                  itemCount: products.length,
                ),
              120.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Widget rootView({
    required BuildContext context,
    required Function onTap,
    required OrdersHistoryResponse order,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                CustomImageNetwork(
                  url: order.products?[0].productImage ?? '',
                  width: 88.w,
                  height: 75.h,
                ),
                8.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 75.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                order.code ?? '',
                                style: TextStyleManager.mediumBlack14px,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),

                            /// todo: trạng thái thanh toán tạm ẩn
                            Expanded(
                              child: Text(
                                '',
                                style: TextStyleManager.style10pxPrimary,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Giá :',
                                  style: TextStyleManager.mediumBlack14px,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${order.amount.toAppNumberFormatWithNull}đ',
                                        style: TextStyleManager.mediumBlack
                                            .copyWith(fontSize: 14.sp)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'X${(order.totalQty ?? 0)}',
                                style: TextStyleManager.normalBlack,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'Ngày đặt : ${HelperInfor.getDate(order.createdAt ?? '', format: 'dd/MM/yyyy')}',
                          style: TextStyleManager.normalBlack,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Divider(color: AppColors.colorE7E7E7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.products?.length ?? 0} Sản phẩm ',
                  style: TextStyleManager.normalBlack,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Tổng thanh toán:  ',
                          style: TextStyleManager.normalBlack,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '${order.subTotal.toAppNumberFormatWithNull}đ ',
                          style: TextStyleManager.normalBlack
                              .copyWith(color: AppColors.colorCA1010),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                          color: HelperInfor.getColor(
                            order.status?.value ?? 'processing',
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        order.status?.label ?? 'Đang xử lý',
                        style: TextStyleManager.smallGrey.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
