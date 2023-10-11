part of 'carts_bloc.dart';

class CartsState extends Equatable {
  final BlocStatusEnum? status;
  final String? errMes;
  final ListCartsResponse? cartsResponse;
  final ConfirmCartResponse? confirmCartResponse;

  const CartsState({
    this.status,
    this.errMes,
    this.cartsResponse,
    this.confirmCartResponse,
  });

  @override
  List<Object?> get props => [
        status,
        errMes,
        cartsResponse,
        confirmCartResponse,
      ];

  bool get isSelectedAll =>
      cartsResponse?.carts?.items
          ?.where((e) => e.isSelected == true)
          .toList()
          .length ==
      cartsResponse?.carts?.items?.length;

  CartsState copyWith({
    BlocStatusEnum? status,
    String? errMes,
    ListCartsResponse? cartsResponse,
    ConfirmCartResponse? confirmCartResponse,
  }) {
    return CartsState(
      status: status ?? this.status,
      errMes: errMes ?? this.errMes,
      cartsResponse: cartsResponse ?? this.cartsResponse,
      confirmCartResponse: confirmCartResponse ?? this.confirmCartResponse,
    );
  }
}
