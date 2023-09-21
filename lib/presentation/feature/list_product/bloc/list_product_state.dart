part of 'list_product_bloc.dart';

class ListProductState extends Equatable {
  final BlocStatusEnum status;
  final List<ProductResponse>? products;
  final String mesErr;

  const ListProductState({
    this.products,
    this.status = BlocStatusEnum.loading,
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [
        products,
        status,
        mesErr,
      ];

  ListProductState copyWith({
    BlocStatusEnum? status,
    List<ProductResponse>? products,
    String? mesErr,
  }) {
    return ListProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
