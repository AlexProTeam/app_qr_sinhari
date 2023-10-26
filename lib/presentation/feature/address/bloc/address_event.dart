part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class GetListAddressEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
}

class DeleteAddressEvent extends AddressEvent {
  final int id;

  const DeleteAddressEvent(this.id);

  @override
  List<Object?> get props => [
        id,
      ];
}

class CreateAddressEvent extends AddressEvent {
  final CUAddressRequest createAddressRequest;

  const CreateAddressEvent(this.createAddressRequest);

  @override
  List<Object?> get props => [createAddressRequest];
}

class UpdateAddressEvent extends AddressEvent {
  final CUAddressRequest updateAddressRequest;

  const UpdateAddressEvent(this.updateAddressRequest);

  @override
  List<Object?> get props => [updateAddressRequest];
}
