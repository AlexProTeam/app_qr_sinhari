import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/entity/noti_model.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../app/di/injection.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  NotificationBloc() : super(const NotificationState()) {
    on<NotificationEvent>((event, emit) {});
    on<InitNotification>((event, emit) async {
      try {
        emit(state.copyWith(
          status: BlocStatusEnum.loading,
        ));
        final data = await _appUseCase.getNotifications();
        emit(state.copyWith(
          status: BlocStatusEnum.success,
          histories: data,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
