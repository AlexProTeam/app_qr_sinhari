import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/all_app_doumain/usecases/app_usecase.dart';
import 'package:qrcode/domain/entity/product_model.dart';

import '../../../../app/managers/const/status_bloc.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  late List<ProductResponse> _products;
  final AppUseCase appUseCase;
  final String url;

  ListProductBloc(this.appUseCase, this.url) : super(const ListProductState()) {
    on<InitListProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        /// todo: check with enum or bool
        if (url == 'product-seller') {
          final result = await appUseCase.getListSeller();
          if ((result.data?.productSellers?.list ?? []).isNotEmpty) {
            _products =
                result.data?.productSellers?.list as List<ProductResponse>;
          }
        } else {
          final result = await appUseCase.getListFeature();
          if ((result.data?.productFeatures?.list ?? []).isNotEmpty) {
            _products =
                result.data?.productFeatures?.list as List<ProductResponse>;
          }
        }

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          products: _products,
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
