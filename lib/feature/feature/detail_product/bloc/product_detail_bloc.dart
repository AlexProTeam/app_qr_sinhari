import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/const/status_bloc.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/injector_container.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ArgumentDetailProductScreen argument;
  DetailProductModel? detailProductModel;

  ProductDetailBloc(this.argument) : super(const ProductDetailState()) {
    on<InitProductDetailEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusBloc.loading));
        if ((argument?.url ?? '').isNotEmpty) {
          final data = await injector<AppClient>().get(
              'scan-qr-code?device_id=${injector<AppCache>().deviceId}&city=hanoi&region=vn&url=${argument?.url ?? ''}');
          detailProductModel =
              DetailProductModel.fromJson(data['data']['data']);
          detailProductModel?.serialCode = data['data']['code_active'];
          if (data['data']['tracking'] != null) {
            detailProductModel?.countScan =
                data['data']['tracking']['totalScan'];
            detailProductModel?.countPersonScan =
                data['data']['tracking']['totalUserScan'];
            detailProductModel?.limitScan =
                data['data']['tracking']['exceeded'];
            detailProductModel?.exceedingScan =
                data['data']['tracking']['exceeding_scan'];
            String? dateTimeScan = data['data']['tracking']['datetime_scan'];
            if (dateTimeScan != null) {
              DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
              DateFormat dateFormatLast = DateFormat("HH:mm - dd/MM/yyyy");
              DateTime datetime = dateFormat.parse(dateTimeScan);
              detailProductModel?.dateTimeScanLimit =
                  dateFormatLast.format(datetime);
            }
          }
        } else {
          final data = await injector<AppClient>()
              .get('products/show/${argument.productId}');
          detailProductModel = DetailProductModel.fromJson(data['data']);
        }

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
