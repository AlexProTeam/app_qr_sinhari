import 'package:flutter/material.dart';

import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

import 'widget/item_header.dart';
import 'widget/item_history.dart';
import 'widget/item_list_status_order.dart';

class InfomationCustomer extends StatefulWidget {
  const InfomationCustomer({Key? key}) : super(key: key);

  @override
  State<InfomationCustomer> createState() => _InfomationCustomerState();
}

class _InfomationCustomerState extends State<InfomationCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '',
        isShowBack: true,
        actions: const [],
      ),
      body: SingleChildScrollView(
       // physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: const [
              ItemHeader(),
              ItemListStatusOrder(),
              ItemHistory()
            ],
          ),
        ),
      ),
    );
  }

  Widget itemStatusOrder() {
    return Container();
  }
}
