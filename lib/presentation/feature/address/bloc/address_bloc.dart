// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/app.dart';
import '../../../../app/managers/status_bloc.dart';
import '../../../../data/app_all_api/models/request/update_address.dart';
import '../../../../data/responses/object_response.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/entity/address_screen.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  AddressBloc() : super(const AddressState()) {
    on<AddressEvent>((event, emit) {});

    on<GetListAddressEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final data = await _appUseCase.getListAddress();

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          listAddressResponse: data,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          message: e.message,
        ));
      }
    });

    on<DeleteAddressEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final deletedAddress =
            await _appUseCase.deleteAddress(addressId: event.id);

        final updatedAddresses = state.listAddressResponse
            .where((address) => address.id != event.id)
            .toList();

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          message: deletedAddress.message ?? '',
          listAddressResponse: updatedAddresses,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          message: e.message,
        ));
      }
    });

    on<CreateAddressEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final data = await _appUseCase.createAddress(
            createAddressRequest: event.createAddressRequest);

        final updatedAddresses = [data, ...state.listAddressResponse];

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          message: 'tạo mới địa chỉ thành công',
          listAddressResponse: updatedAddresses,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          message: e.message,
        ));
      }
    });

    on<UpdateAddressEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(status: BlocStatusEnum.loading));

          final data = await _appUseCase.updateAddress(
            updateAddressRequest: event.updateAddressRequest,
          );

          List<AddressResponse> newList = state.listAddressResponse.map((e) {
            /// If the ID matches, replace the old address with the updated one
            if (e.id == data.id) {
              return data;
            }
            return e;
          }).toList();

          emit(state.copyWith(
            status: BlocStatusEnum.success,
            message: 'Cập nhật địa chỉ thành công',
            listAddressResponse: newList,
          ));
        } on ApiException catch (e) {
          emit(state.copyWith(
            status: BlocStatusEnum.failed,
            message: e.message,
          ));
        }
      },
    );
  }
}
