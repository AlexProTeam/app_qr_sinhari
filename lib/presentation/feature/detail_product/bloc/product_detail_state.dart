part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final BlocStatusEnum status;
  final DataDetail? detailProductModel;
  final String errMes;

  const ProductDetailState({
    this.detailProductModel,
    this.status = BlocStatusEnum.init,
    this.errMes = '',
  });

  @override
  List<Object?> get props => [
        detailProductModel,
        status,
        errMes,
      ];

  ProductDetailState copyWith({
    BlocStatusEnum? status,
    DataDetail? detailProductModel,
    String? errMes,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      detailProductModel: detailProductModel ?? this.detailProductModel,
      errMes: errMes ?? this.errMes,
    );
  }
}
