import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/domain/entity/detail_product_model.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/managers/const/status_bloc.dart';
import '../../../../app/route/common_util.dart';
import '../detail_product_screen.dart';

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
              getIt<AppCache>().deviceId ?? '',
              'hanoi',
              'vn',
              argument.url ?? '');
          // getIt<AppClient>().get(
          //     'scan-qr-code?device_id=${getIt<AppCache>().deviceId}&city=hanoi&region=vn&url=${argument.url ?? ''}');
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
