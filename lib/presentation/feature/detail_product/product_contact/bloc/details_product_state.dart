part of 'details_product_bloc.dart';

class DetailsProductState extends Equatable {
  final BlocStatusEnum status;
  final String errMes;

  const DetailsProductState({
    this.status = BlocStatusEnum.loading,
    this.errMes = '',
  });

  @override
  List<Object?> get props => [status, errMes];

  DetailsProductState copyWith({
    BlocStatusEnum? status,
    String? errMes,
  }) {
    return DetailsProductState(
      status: status ?? this.status,
      errMes: errMes ?? this.errMes,
    );
  }
}
