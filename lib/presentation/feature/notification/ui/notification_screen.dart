import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/managers/color_manager.dart';
import '../../../../app/route/enum_app_status.dart';
import '../../../widgets/custom_scaffold.dart';
import '../bloc/notification_bloc.dart';
import '../widget/notification_widget.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  NotiScreenState createState() => NotiScreenState();
}

class NotiScreenState extends State<NotiScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thông báo',
        isShowBack: true,
      ),
      backgroundColor: AppColors.bgrScafold,
      body: BlocProvider(
        create: (context) => NotificationBloc()..add(InitNotification()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state.status == ScreenStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.histories.isEmpty) {
              return const Center(
                child: Text("Không có thông báo nào!"),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (_, index) =>
                  itemNotification(state.histories[index]),
              itemCount: state.histories.length,
            );
          },
        ),
      ),
    );
  }
}
