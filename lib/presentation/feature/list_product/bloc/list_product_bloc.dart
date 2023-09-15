import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qrcode/common/model/product_model.dart';

import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../app/managers/const/status_bloc.dart';
import '../../../../app/route/common_util.dart';

part 'list_product_event.dart';

part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  late List<ProductResponse> _products;
  final AppUseCase appUseCase;
  final String title;

  ListProductBloc(this.appUseCase, this.title)
      : super(const ListProductState()) {
    on<InitListProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        if (title == 'product-seller') {
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
      } catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
        ));
        CommonUtil.handleException(e, methodName: '');
      }
    });

    on<ClearListProductEvent>((event, emit) async {
      emit(state.copyWith(
        products: null,
      ));
    });
  }
}
