import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';

import '../../../../app/managers/status_bloc.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/entity/add_to_cart_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  DataDetail? detailProductModel;
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  ProductDetailBloc() : super(const ProductDetailState()) {
    on<InitProductDetailEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        if ((event.argument.url ?? '').isNotEmpty) {
          final data = await _appUseCase.getDetaiProductByQr(
              SessionUtils.deviceId, 'hanoi', 'vn', event.argument.url ?? '');

          detailProductModel = data.data;
        } else {
          final data =
              await _appUseCase.getDetaiProduct(event.argument.productId ?? 0);
          detailProductModel = data;
        }

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          detailProductModel: detailProductModel,
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
        detailProductModel: null,
      ));
    });

    on<OnClickBuyEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        await _appUseCase.saveContact(
          productId: event.id.toString(),
          content: event.content.text,
          type: 0,
        );

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

    on<OnClickAddToCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final data = await _appUseCase.addToCart(productId: event.proId);

        emit(state.copyWith(
            status: BlocStatusEnum.success, addToCartModel: data));
      } catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
        ));
      }
    });
  }
}
