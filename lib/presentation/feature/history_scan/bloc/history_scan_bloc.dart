import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/route/common_util.dart';
import '../../../../app/route/enum_app_status.dart';
import '../../../../common/local/app_cache.dart';
import '../../../../common/network/client.dart';
import '../../../../domain/login/usecases/app_usecase.dart';
import '../history_model.dart';

part 'history_scan_event.dart';
part 'history_scan_state.dart';

class HistoryScanBloc extends Bloc<HistoryScanEvent, HistoryScanState> {
  final AppUseCase _repository = getIt<AppUseCase>();

  HistoryScanBloc() : super(const HistoryScanState()) {
    on<HistoryScanEvent>((event, emit) {});

    on<InitDataHistoryEvent>((event, emit) async {
      List<HistoryModel> histories = [];
      try {
        emit(state.copyWith(status: ScreenStatus.loading));
        // final listData = await _repository
        //     .getHistoryScanQrCode(getIt<AppCache>().deviceId ?? '');

        final data = await getIt<AppClient>().get(
            'history-scan-qr-code?device_id=${getIt<AppCache>().deviceId}');
        data['data'][0].forEach((e) {
          histories.add(data as HistoryModel);
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
