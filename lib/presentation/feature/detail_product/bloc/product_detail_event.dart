part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class InitProductDetailEvent extends ProductDetailEvent {
  final ArgumentDetailProductScreen argument;

  const InitProductDetailEvent(this.argument);

  @override
  List<Object?> get props => [argument];
}

class ClearProductDetailEvent extends ProductDetailEvent {
  const ClearProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnClickBuyEvent extends ProductDetailEvent {
  final int id;
  final TextEditingController content;

  const OnClickBuyEvent({
    required this.id,
    required this.content,
  });

  @override
  List<Object?> get props => [
        id,
        content,
      ];
}

class OnAddToCartEvent extends ProductDetailEvent {
  final int proId;
  final bool isAddToCartOnly;

  const OnAddToCartEvent({
    required this.proId,
    this.isAddToCartOnly = true,
  });

  @override
  List<Object?> get props => [
        proId,
        isAddToCartOnly,
      ];
}
