import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';

import '../../../../app/managers/status_bloc.dart';
import '../../../../data/utils/exceptions/api_exception.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ArgumentDetailProductScreen argument;
  DataDetail? detailProductModel;
  final AppUseCase appUseCase;

  ProductDetailBloc(this.argument, this.appUseCase)
      : super(const ProductDetailState()) {
    on<InitProductDetailEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        if ((argument.url ?? '').isNotEmpty) {
          final data = await appUseCase.getDetaiProductByQr(
              SessionUtils.deviceId, 'hanoi', 'vn', argument.url ?? '');

          detailProductModel = data.data;
        } else {
          final data =
              await appUseCase.getDetaiProduct(argument.productId ?? 0);
          detailProductModel = data;
        }

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          detailProductModel: detailProductModel,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
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
        await appUseCase.saveContact(
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
  }
}
