part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final StatusBloc status;
  final DetailProductModel? detailProductModel;

  const ProductDetailState({
    this.detailProductModel,
    this.status = StatusBloc.init,
  });

  @override
  List<Object?> get props => [detailProductModel, status];

  ProductDetailState copyWith({
    StatusBloc? status,
    DetailProductModel? detailProductModel,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      detailProductModel: detailProductModel,
    );
  }
}
