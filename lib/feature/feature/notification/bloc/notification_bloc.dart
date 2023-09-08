import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';

import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../../re_base/app/di/injector_container.dart';
import '../noti_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<NotificationEvent>((event, emit) {});
    on<InitNotification>((event, emit) async {
      List<NotiModel> histories = [];
      try {
        await Future.delayed(const Duration(milliseconds: 100));
        emit(state.copyWith(status: ScreenStatus.loading));
        final data = await injector<AppClient>()
            .post('notifications', handleResponse: false);
        data['notifications'].forEach((e) {
          histories.add(NotiModel.fromJson(e));
        });
        emit(
            state.copyWith(status: ScreenStatus.success, histories: histories));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
        CommonUtil.handleException(e, methodName: '');
      }
    });
  }
}
