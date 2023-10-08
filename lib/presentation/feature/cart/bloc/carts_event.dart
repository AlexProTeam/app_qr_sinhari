part of 'carts_bloc.dart';

abstract class CartsEvent extends Equatable {
  const CartsEvent();
}

class InitDataCartEvent extends CartsEvent {
  const InitDataCartEvent();

  @override
  List<Object?> get props => [];
}

class ChangeQualityCartEvent extends CartsEvent {
  final int productId;
  final int quality;

  const ChangeQualityCartEvent(this.productId, this.quality);

  @override
  List<Object?> get props => [productId, quality];
}

class ConfirmCartEvent extends CartsEvent {
  const ConfirmCartEvent();

  @override
  List<Object?> get props => [];
}
