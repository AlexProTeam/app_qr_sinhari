import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/model/product_model.dart';
import 'package:qrcode/common/network/client.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/managers/const/status_bloc.dart';
import '../../../../app/route/common_util.dart';
import '../list_product_screen.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final List<ProductResponse> _products = [];
  final ArgumentListProductScreen argumentListProductScreen;

  ListProductBloc(this.argumentListProductScreen)
      : super(const ListProductState()) {
    on<InitListProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final dataSeller = await getIt<AppClient>()
            .get('${argumentListProductScreen.url}?page=1');
        String? key =
            (argumentListProductScreen.url ?? '').contains('product-seller')
                ? 'productSellers'
                : null;
        dataSeller['data'][key ?? 'productFeatures']['data'].forEach((e) {
          _products.add(ProductResponse.fromJson(e));
        });

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
