import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';

import '../../../../data/utils/exceptions/api_exception.dart';

part 'history_debt_event.dart';

part 'history_debt_state.dart';

class HistoryDebtBloc extends Bloc<HistoryDebtEvent, HistoryDebtState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  HistoryDebtBloc() : super(const HistoryDebtState()) {
    on<HistoryDebtEvent>((event, emit) {});
    on<InitDebtEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final data = await _appUseCase.getShowProfile();

        emit(state.copyWith(
          status: BlocStatusEnum.success,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
        ));
      }
    });
  }
}
