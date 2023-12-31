import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';

import '../../../../app/managers/status_bloc.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/entity/add_to_cart_model.dart';
import '../../../../domain/entity/detail_order_response.dart';

part 'detail_order_event.dart';
part 'detail_order_state.dart';

class DetailOrderBloc extends Bloc<DetailOrderEvent, DetailOrderState> {
  DataOrderDetail? dataOrderDetail;
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  DetailOrderBloc() : super(const DetailOrderState()) {
    on<InitDetailOrderEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final data = await _appUseCase.getDetailOrder(proId: event.id);
        dataOrderDetail = data.data;

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          dataOrderDetail: dataOrderDetail,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });

    on<ClearProductDetailEvent>((event, emit) async {
      emit(state.copyWith(
        dataOrderDetail: null,
      ));
    });
  }
}
