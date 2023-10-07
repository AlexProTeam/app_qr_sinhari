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
      List<OrderModel>? listData;
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        /// todo: check with enum or bool
        final result = await appUseCase.getListOrder();
        if ((result.data?.orders ?? []).isNotEmpty) {
          listData = result.data?.orders as List<OrderModel>;
        }

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          products: listData,
        ));
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
