import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';
import 'package:qrcode/feature/feature/notification/bloc/notification_bloc.dart';
import 'package:qrcode/feature/feature/notification/widget/notification_widget.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../../themes/theme_color.dart';

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
