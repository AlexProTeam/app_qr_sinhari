part of 'details_product_active_bloc.dart';

abstract class DetailsProductActiveState extends Equatable {
  const DetailsProductActiveState();
}

class DetailsProductState extends Equatable {
  final ScreenStatus status;

  const DetailsProductState({this.status = ScreenStatus.loading});

  DetailsProductState copyWith({ScreenStatus? status}) {
    return DetailsProductState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
