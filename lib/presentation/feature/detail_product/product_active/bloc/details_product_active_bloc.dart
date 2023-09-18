import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/network/client.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/common_util.dart';
import '../../../../../app/route/enum_app_status.dart';

part 'details_product_active_event.dart';
part 'details_product_active_state.dart';

class DetailsProductActiveBloc
    extends Bloc<DetailsProductActiveEvent, DetailsProductState> {
  DetailsProductActiveBloc() : super(const DetailsProductState()) {
    on<DetailsProductActiveEvent>((event, emit) {});
    on<InitDetailsProductEvent>((event, emit) async {
      try {
        if (!CommonUtil.validateAndSave(event.formKey)) return;
        emit(state.copyWith(status: ScreenStatus.loading));
        await getIt<AppClient>().post(
            'save-contact?product_id=${event.arg}&content=${event.content.text}&type=1');
        emit(state.copyWith(status: ScreenStatus.success));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
        CommonUtil.handleException(e, methodName: 'getThemes CourseCubit');
      }
    });
  }
}