import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/domain/entity/detail_order.dart';
import 'package:qrcode/presentation/feature/detail_order/bloc/detail_order_bloc.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/adress_recive.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/item_list.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

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
          child: BlocBuilder<DetailOrderBloc, DetailOrderState>(
              builder: (BuildContext context, state) {
            final products = state.dataOrderDetail;
            if (state.status == BlocStatusEnum.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if ((products?.orderDetail?.products ?? []).isEmpty) {
              return const Center(
                child: Text("Không có sản phẩm nào!"),
              );
            }
            return Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products?.orderDetail?.products?.length,
                    itemBuilder: (context, index) {
                      return ItemList(
                        products: products?.orderDetail?.products?[index] ??
                            Products(),
                      );
                    }),
                AdressRecive(
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
