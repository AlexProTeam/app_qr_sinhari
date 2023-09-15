part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final BlocStatusEnum status;
  final DataDetail? detailProductModel;

  const ProductDetailState({
    this.detailProductModel,
    this.status = BlocStatusEnum.init,
  });

  @override
  List<Object?> get props => [detailProductModel, status];

  ProductDetailState copyWith({
    BlocStatusEnum? status,
    DataDetail? detailProductModel,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      detailProductModel: detailProductModel,
    );
  }
}
