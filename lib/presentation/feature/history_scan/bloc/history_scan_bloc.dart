import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/domain/all_app_doumain/usecases/app_usecase.dart';

import '../history_model.dart';

part 'history_scan_event.dart';
part 'history_scan_state.dart';

class HistoryScanBloc extends Bloc<HistoryScanEvent, HistoryScanState> {
  final AppUseCase _repository = getIt<AppUseCase>();

  HistoryScanBloc() : super(const HistoryScanState()) {
    on<HistoryScanEvent>((event, emit) {});

    on<InitDataHistoryEvent>((event, emit) async {
      ///todo: api đang trả ra "[[]] cần refactor lại data"
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final data =
            await _repository.getHistoryScanQrCode(SessionUtils.deviceId);

        emit(state.copyWith(status: BlocStatusEnum.success, histories: data));
      } catch (e) {
        emit(state.copyWith(status: BlocStatusEnum.failed));
      }
    });
  }
}
