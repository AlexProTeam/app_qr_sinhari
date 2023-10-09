// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/app.dart';
import '../../../../app/managers/status_bloc.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/entity/list_carts_response.dart';

part 'carts_event.dart';
part 'carts_state.dart';

class CartsBloc extends Bloc<CartsEvent, CartsState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  CartsBloc() : super(const CartsState()) {
    on<CartsEvent>((event, emit) {});

    on<InitDataCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final result = await _appUseCase.getListCart();

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          cartsResponse: result,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });

    on<ChangeQualityCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        await _appUseCase.postQuality(
            productId: event.productId, qty: event.quality);

        List<ItemsCarts> listData = state.cartsResponse?.carts?.items ?? [];

        listData[event.index] = listData[event.index].copyWith(
          qty: event.quality.toString(),
        );

        emit(
          state.copyWith(
            status: BlocStatusEnum.success,
            cartsResponse: state.cartsResponse?.copyWith(
              carts: state.cartsResponse?.carts?.copyWith(
                items: listData,
              ),
            ),
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });

    on<ConfirmCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        await _appUseCase.postConfirmCart();
        emit(state.copyWith(
          status: BlocStatusEnum.success,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });

    on<DeleteCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final result = await _appUseCase.deleteItemCart(id: event.itemId);

        final listData = state.cartsResponse?.carts?.items ?? [];

        listData.removeAt(event.index);

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          errMes: result.message,
          cartsResponse: state.cartsResponse?.copyWith(
            carts: state.cartsResponse?.carts?.copyWith(
              items: listData,
            ),
          ),
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
