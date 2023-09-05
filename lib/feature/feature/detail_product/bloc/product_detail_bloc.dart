import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/const/status_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState()) {
    on<InitProductDetailEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusBloc.loading));
        final data = await injector<AppClient>()
            .get('products/show/${injector<AppCache>().cacheProductId}');
        DetailProductModel detailProductModel =
            DetailProductModel.fromJson(data['data']);

        emit(state.copyWith(
          status: StatusBloc.success,
          detailProductModel: detailProductModel,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: StatusBloc.failed,
        ));
        CommonUtil.handleException(e, methodName: '');
      }
    });

    on<ClearProductDetailEvent>((event, emit) async {
      emit(state.copyWith(
        detailProductModel: null,
      ));
    });
  }
}
