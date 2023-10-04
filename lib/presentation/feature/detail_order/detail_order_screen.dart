import 'package:flutter/material.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/adress_recive.dart';
import 'package:qrcode/presentation/feature/detail_order/widget/item_list.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

class DetailOderScreen extends StatefulWidget {
  const DetailOderScreen({Key? key}) : super(key: key);

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
        actions: const [],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const ItemList();
                }),
            const AdressRecive()
          ],
        ),
      ),
    );
  }
}
