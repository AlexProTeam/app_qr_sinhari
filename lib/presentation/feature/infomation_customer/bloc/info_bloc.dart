import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/entity/order_model.dart';

import '../../../../app/managers/status_bloc.dart';

part 'info_event.dart';

part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final AppUseCase appUseCase;
  final String url;

  InfoBloc(this.appUseCase, this.url) : super(const InfoState()) {
    on<InitListProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final result = await appUseCase.getListOrder(statusOrder: event.status);
        emit(
          state.copyWith(
            status: BlocStatusEnum.success,
            products: result.orders ?? [],
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          mesErr: e.message,
        ));
      }
    });

    on<ClearListProductEvent>((event, emit) async {
      emit(state.copyWith(
        products: null,
      ));
    });
  }
}
