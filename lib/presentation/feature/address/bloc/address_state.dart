part of 'address_bloc.dart';

class AddressState extends Equatable {
  final String message;
  final BlocStatusEnum status;
  final List<AddressResponse> listAddressResponse;

  /// for detail and create
  final AddressResponse? addressResponse;
  final ObjectResponse? objectResponse;
  final bool isCanPop;

  const AddressState({
    this.message = '',
    this.status = BlocStatusEnum.init,
    this.listAddressResponse = const [],
    this.addressResponse,
    this.objectResponse,
    this.isCanPop = false,
  });

  @override
  List<Object?> get props => [
        message,
        status,
        listAddressResponse,
        addressResponse,
        objectResponse,
        isCanPop,
      ];

  AddressState copyWith({
    String? message,
    BlocStatusEnum? status,
    List<AddressResponse>? listAddressResponse,
    AddressResponse? addressResponse,
    ObjectResponse? objectResponse,
    bool? isCanPop,
  }) {
    return AddressState(
      message: message ?? '',
      status: status ?? this.status,
      listAddressResponse: listAddressResponse ?? this.listAddressResponse,
      addressResponse: addressResponse ?? this.addressResponse,
      objectResponse: objectResponse ?? this.objectResponse,
      isCanPop: isCanPop ?? this.isCanPop,
    );
  }
}
