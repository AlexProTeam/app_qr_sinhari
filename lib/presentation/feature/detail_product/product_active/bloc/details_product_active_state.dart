part of 'details_product_active_bloc.dart';

abstract class DetailsProductActiveState extends Equatable {
  const DetailsProductActiveState();
}

class DetailsProductState extends Equatable {
  final BlocStatusEnum status;

  const DetailsProductState({this.status = BlocStatusEnum.loading});

  DetailsProductState copyWith({BlocStatusEnum? status}) {
    return DetailsProductState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
