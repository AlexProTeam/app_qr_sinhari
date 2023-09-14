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
