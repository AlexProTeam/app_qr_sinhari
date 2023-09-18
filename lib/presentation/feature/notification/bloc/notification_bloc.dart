import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/route/common_util.dart';
import '../../../../app/route/enum_app_status.dart';
import '../../../../common/network/client.dart';
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
        final data = await getIt<AppClient>()
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