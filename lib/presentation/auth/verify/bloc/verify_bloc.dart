import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';

import '../../../../data/utils/exceptions/api_exception.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AppUseCase appUseCase;

  VerifyBloc(
    this.appUseCase,
  ) : super(const VerifyState()) {
    on<TapEvent>((event, emit) async {
      try {
        emit(state.copyWith(
          status: BlocStatusEnum.loading,
        ));
        final result = await appUseCase.comfirmOtp(event.phone, event.otp);

        if (result.success == false) {
          emit(state.copyWith(
            status: BlocStatusEnum.failed,
            mesErr: result.message,
          ));
          return;
        }

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          token: result.data?.result?.accessToken,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          mesErr: e.message,
        ));
      }
    });
  }
}
