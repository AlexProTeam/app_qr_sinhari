import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/entity/product_model.dart';

import '../../../../app/managers/status_bloc.dart';

part 'list_product_event.dart';

part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final AppUseCase appUseCase;
  final String url;

  ListProductBloc(this.appUseCase, this.url) : super(const ListProductState()) {
    on<InitListProductEvent>((event, emit) async {
      List<ProductResponse>? products;
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        /// todo: check with enum or bool
        if (url == 'product-seller') {
          final result = await appUseCase.getListSeller();
          if ((result.data?.productSellers?.list ?? []).isNotEmpty) {
            products =
                result.data?.productSellers?.list as List<ProductResponse>;
          }
        } else if (url == 'product_agency') {
          final result = await appUseCase.getListAngecy();
          if ((result.data?.listAngecy ?? []).isNotEmpty) {
            products = result.data?.listAngecy as List<ProductResponse>;
          }
        } else {
          final result = await appUseCase.getListFeature();
          if ((result.data?.productFeatures?.list ?? []).isNotEmpty) {
            products =
                result.data?.productFeatures?.list as List<ProductResponse>;
          }
        }

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          products: products,
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
