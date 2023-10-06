part of 'carts_bloc.dart';

class CartsState extends Equatable {
  final BlocStatusEnum? status;
  final String? errMes;
  final ListCartsResponse? cartsResponse;

  const CartsState({
    this.status,
    this.errMes,
    this.cartsResponse,
  });

  @override
  List<Object?> get props => [
        status,
        errMes,
        cartsResponse,
      ];

  CartsState copyWith({
    BlocStatusEnum? status,
    String? errMes,
    ListCartsResponse? cartsResponse,
  }) {
    return CartsState(
      status: status ?? this.status,
      errMes: errMes ?? this.errMes,
      cartsResponse: cartsResponse ?? this.cartsResponse,
    );
  }
}
