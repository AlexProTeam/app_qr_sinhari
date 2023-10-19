// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/data/responses/object_response.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';

import '../../../../domain/entity/payment_debt_model.dart';

part 'pay_debt_event.dart';

part 'pay_debt_state.dart';

class PayDebtBloc extends Bloc<PayDebtEvent, PayDebtState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  PayDebtBloc() : super(const PayDebtState()) {
    on<PayDebtEvent>((event, emit) {});
    on<InitDataPayEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final result =
            await _appUseCase.payMent(amount: int.parse(event.mount!));
        emit(state.copyWith(
            status: BlocStatusEnum.success, payment: result.data));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
    on<OnClickPayEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final result = await _appUseCase.paymentConfirm();
        emit(state.copyWith(
            status: BlocStatusEnum.success,
            data: result,
            payment: event.payment));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
