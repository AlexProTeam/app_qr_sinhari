import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/widgets/dialog_manager_custom.dart';

part 'details_product_event.dart';

part 'details_product_state.dart';

class DetailsProductBloc
    extends Bloc<DetailsProductEvent, DetailsProductState> {
  DetailsProductBloc() : super(const DetailsProductState()) {
    on<DetailsProductEvent>((event, emit) {});
    on<OnClickBuyEvent>((event, emit) async {
      try {
        // if (!event.formKey.currentState!.validate()) return;
        emit(state.copyWith(status: ScreenStatus.loading));

        await injector<AppClient>().post(
            'save-contact?product_id=${event.arg}&content=${event.content.text}&type=0');
        emit(state.copyWith(status: ScreenStatus.success));
      } catch (e) {
        emit(state.copyWith(status: ScreenStatus.failed));
      }
      DialogManager.hideLoadingDialog;
    });
  }
}
