part of 'list_product_bloc.dart';

class ListProductState extends Equatable {
  final BlocStatusEnum status;
  final List<ProductResponse>? products;

  const ListProductState({
    this.products,
    this.status = BlocStatusEnum.init,
  });

  @override
  List<Object?> get props => [products, status];

  ListProductState copyWith({
    BlocStatusEnum? status,
    List<ProductResponse>? products,
  }) {
    return ListProductState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
