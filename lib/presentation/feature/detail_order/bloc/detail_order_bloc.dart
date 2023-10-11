import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/detail_order.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';

import '../../../../app/managers/status_bloc.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/entity/add_to_cart_model.dart';

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
            status: BlocStatusEnum.success, dataOrderDetail: dataOrderDetail));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          dataOrderDetail: dataOrderDetail,
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
