import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/presentation/feature/detail_order/bloc/detail_order_bloc.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/adress_recive.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/item_list.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../domain/entity/detail_order_response.dart';

class DetailOderScreen extends StatefulWidget {
  final int? proId;

  const DetailOderScreen({Key? key, this.proId}) : super(key: key);

  @override
  State<DetailOderScreen> createState() => _DetailOderScreenState();
}

class _DetailOderScreenState extends State<DetailOderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Chi tiết đơn hàng',
        isShowBack: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocProvider(
          create: (context) => DetailOrderBloc()
            ..add(InitDetailOrderEvent(id: widget.proId ?? 0)),
          child: BlocConsumer<DetailOrderBloc, DetailOrderState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.status == BlocStatusEnum.failed) {
                  ToastManager.showToast(
                    context,
                    text: state.errMes,
                  );
                }
              },
              buildWhen: (previous, current) => previous != current,
              builder: (BuildContext context, state) {
                if (state.status == BlocStatusEnum.loading) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2 - 30,
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                final products = state.dataOrderDetail;

                if ((products?.orderDetail?.products ?? []).isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2 - 30,
                    ),
                    child: const Center(
                      child: Text("Không có sản phẩm nào!"),
                    ),
                  );
                }
                return Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products?.orderDetail?.products?.length,
                      itemBuilder: (context, index) {
                        return ItemListViewDetailOrdersWidget(
                          products: products?.orderDetail?.products?[index] ??
                              Products(),
                        );
                      },
                    ),

                    /// thông tin đơn hàng
                    InformationDetailOrdersWidget(
                      orderDetail: products?.orderDetail ?? OrderDetail(),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
