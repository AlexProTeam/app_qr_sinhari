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
  final int index;

  const ChangeQualityCartEvent(this.productId, this.quality, this.index);

  @override
  List<Object?> get props => [productId, quality, index];
}

class ConfirmCartEvent extends CartsEvent {
  const ConfirmCartEvent();

  @override
  List<Object?> get props => [];
}

class DeleteCartEvent extends CartsEvent {
  final int itemId;
  final int index;

  const DeleteCartEvent(this.itemId, this.index);

  @override
  List<Object?> get props => [
        itemId,
        index,
      ];
}
