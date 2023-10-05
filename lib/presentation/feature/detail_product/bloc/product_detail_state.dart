part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final BlocStatusEnum status;
  final DataDetail? detailProductModel;
  final String errMes;
  final CartsResponse? addToCartModel;

  const ProductDetailState(
      {this.detailProductModel,
      this.status = BlocStatusEnum.init,
      this.errMes = '',
      this.addToCartModel});

  @override
  List<Object?> get props =>
      [detailProductModel, status, errMes, addToCartModel];

  ProductDetailState copyWith(
      {BlocStatusEnum? status,
      DataDetail? detailProductModel,
      String? errMes,
      CartsResponse? addToCartModel}) {
    return ProductDetailState(
      status: status ?? this.status,
      detailProductModel: detailProductModel ?? this.detailProductModel,
      errMes: errMes ?? this.errMes,
      addToCartModel: addToCartModel ?? this.addToCartModel,
    );
  }
}
