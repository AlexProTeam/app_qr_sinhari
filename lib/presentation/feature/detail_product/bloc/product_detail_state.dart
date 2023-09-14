part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final BlocStatusEnum status;
  final DetailProductModel? detailProductModel;

  const ProductDetailState({
    this.detailProductModel,
    this.status = BlocStatusEnum.init,
  });

  @override
  List<Object?> get props => [detailProductModel, status];

  ProductDetailState copyWith({
    BlocStatusEnum? status,
    DetailProductModel? detailProductModel,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      detailProductModel: detailProductModel,
    );
  }
}
