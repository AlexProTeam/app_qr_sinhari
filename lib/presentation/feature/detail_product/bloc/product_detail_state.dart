part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final BlocStatusEnum status;
  final DataDetail? detailProductModel;
  final String errMes;
  final OrderCartsResponse? addToCartModel;
  final bool isAddToCartOnly;

  const ProductDetailState({
    this.detailProductModel,
    this.status = BlocStatusEnum.init,
    this.errMes = '',
    this.addToCartModel,
    this.isAddToCartOnly = true,
  });

  @override
  List<Object?> get props => [
        detailProductModel,
        status,
        errMes,
        addToCartModel,
        isAddToCartOnly,
      ];

  bool get isNavigateToCartScreen =>
      addToCartModel?.carts != null &&
      status == BlocStatusEnum.success &&
      !isAddToCartOnly;

  ProductDetailState copyWith({
    BlocStatusEnum? status,
    DataDetail? detailProductModel,
    String? errMes,
    OrderCartsResponse? addToCartModel,
    bool? isAddToCartOnly,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      detailProductModel: detailProductModel ?? this.detailProductModel,
      errMes: errMes ?? '',
      addToCartModel: addToCartModel ?? this.addToCartModel,
      isAddToCartOnly: isAddToCartOnly ?? this.isAddToCartOnly,
    );
  }
}
