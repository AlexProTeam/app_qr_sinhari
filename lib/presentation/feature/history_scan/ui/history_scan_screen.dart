import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';

import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/nested_route_wrapper.dart';
import '../../bottom_bar_screen/enum/bottom_bar_enum.dart';
import '../bloc/history_scan_bloc.dart';
import '../widget/item_history_scan_widget.dart';

class ScanHistoryNested extends StatelessWidget {
  const ScanHistoryNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateDefaultRoute,
      navigationKey: Routes.historyScanKey,
      initialRoute: BottomBarEnum.lichSuQuet.getRouteNames,
    );
  }
}

class HistoryScanScreen extends StatefulWidget {
  const HistoryScanScreen({Key? key}) : super(key: key);

  @override
  HistoryScanScreenState createState() => HistoryScanScreenState();
}

class HistoryScanScreenState extends State<HistoryScanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Lịch sử QR'),
      body: BlocProvider(
        create: (context) => HistoryScanBloc()..add(InitDataHistoryEvent()),
        child: BlocBuilder<HistoryScanBloc, HistoryScanState>(
          buildWhen: (previous, current) => previous != current,
          builder: (BuildContext context, state) {
            if (state.status == BlocStatusEnum.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.histories.isEmpty) {
              return const Center(child: Text("Không có lịch sử nào!"));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HistoryScanBloc>().add(InitDataHistoryEvent());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      '${state.histories.length} Sản phẩm',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        padding: const EdgeInsets.only(bottom: 100),
                        itemBuilder: (_, index) {
                          return itemHistoryScan(
                              context, state.histories[index]);
                        },
                        itemCount: state.histories.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
