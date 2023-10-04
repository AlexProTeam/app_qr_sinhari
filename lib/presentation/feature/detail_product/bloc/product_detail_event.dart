part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class InitProductDetailEvent extends ProductDetailEvent {
  final ArgumentDetailProductScreen argument;
  final AppUseCase appUseCase;

  const InitProductDetailEvent(this.argument, this.appUseCase);

  @override
  List<Object?> get props => [argument, appUseCase];
}

class ClearProductDetailEvent extends ProductDetailEvent {
  const ClearProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnClickBuyEvent extends ProductDetailEvent {
  final AppUseCase appUseCase;
  final int id;
  final TextEditingController content;

  const OnClickBuyEvent({
    required this.appUseCase,
    required this.id,
    required this.content,
  });

  @override
  List<Object?> get props => [
        id,
        content,
      ];
}

class OnClickAddToCartEvent extends ProductDetailEvent {
  final AppUseCase appUseCase;
  final int proId;

  const OnClickAddToCartEvent({
    required this.appUseCase,
    required this.proId,
  });

  @override
  List<Object?> get props => [
        appUseCase,
        proId,
      ];
}
