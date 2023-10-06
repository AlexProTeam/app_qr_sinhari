part of 'carts_bloc.dart';

abstract class CartsEvent extends Equatable {
  const CartsEvent();
}

class InitDataCartEvent extends CartsEvent {
  const InitDataCartEvent();

  @override
  List<Object?> get props => [];
}
