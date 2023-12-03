import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

import 'bloc/info_bloc.dart';
import 'widget/item_header.dart';
import 'widget/item_history.dart';
import 'widget/item_list_status_order.dart';

class InfomationCustomer extends StatefulWidget {
  const InfomationCustomer({Key? key}) : super(key: key);

  @override
  State<InfomationCustomer> createState() => _InfomationCustomerState();
}

class _InfomationCustomerState extends State<InfomationCustomer> {
  late final InfoBloc _infoBloc;

  @override
  void initState() {
    _infoBloc = context.read<InfoBloc>();
    _infoBloc.add(
      const InitListProductEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '',
        isShowBack: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: const [
              ItemHeaderProfileBill(),
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
