import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../../app/di/injection.dart';

part 'details_product_event.dart';
part 'details_product_state.dart';

class DetailsProductBloc
    extends Bloc<DetailsProductEvent, DetailsProductState> {
  final AppUseCase appUseCase = getIt<AppUseCase>();

  DetailsProductBloc() : super(const DetailsProductState()) {
    on<DetailsProductEvent>((event, emit) {});
    on<OnClickBuyEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        await appUseCase.saveContact(
          productId: event.arg.toString(),
          content: event.content.text,
          type: 0,
        );

        emit(state.copyWith(status: BlocStatusEnum.success));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
