import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/status_bloc.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/list_product/list_product_screen.dart';

import '../../../../re_base/app/di/injector_container.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final List<ProductResponse> _products = [];
  final ArgumentListProductScreen argumentListProductScreen;

  ListProductBloc(this.argumentListProductScreen)
      : super(const ListProductState()) {
    on<InitListProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusBloc.loading));

        final dataSeller = await injector<AppClient>()
            .get('${argumentListProductScreen.url}?page=1');
        String? key =
            (argumentListProductScreen.url ?? '').contains('product-seller')
                ? 'productSellers'
                : null;
        dataSeller['data'][key ?? 'productFeatures']['data'].forEach((e) {
          _products.add(ProductResponse.fromJson(e));
        });

        emit(state.copyWith(
          status: StatusBloc.success,
          products: _products,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: StatusBloc.failed,
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
