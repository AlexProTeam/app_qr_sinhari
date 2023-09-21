part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class InitProductDetailEvent extends ProductDetailEvent {
  const InitProductDetailEvent();

  @override
  List<Object?> get props => [];
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
