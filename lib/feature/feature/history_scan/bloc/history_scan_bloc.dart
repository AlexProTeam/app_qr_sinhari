import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';
import 'package:qrcode/feature/feature/history_scan/history_model.dart';

import '../../../../common/local/app_cache.dart';
import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../injector_container.dart';

part 'history_scan_event.dart';
part 'history_scan_state.dart';

class HistoryScanBloc extends Bloc<HistoryScanEvent, HistoryScanState> {
  HistoryScanBloc() : super(const HistoryScanState()) {
    on<HistoryScanEvent>((event, emit) {});

    on<InitDataHistoryEvent>((event, emit) async {
      List<HistoryModel> histories = [];
      try {
        emit(state.copyWith(status: ScreenStatus.loading));
        final data = await injector<AppClient>().get(
            'history-scan-qr-code?device_id=${injector<AppCache>().deviceId}');
        data['data'][0].forEach((e) {
          histories.add(HistoryModel.fromJson(e));
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
