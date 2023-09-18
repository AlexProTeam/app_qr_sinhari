part of 'details_news_bloc.dart';

class DetailsNewsState extends Equatable {
  final ScreenStatus status;
  final NewsDetails? data;
  final String? errMes;

  const DetailsNewsState({
    this.status = ScreenStatus.loading,
    this.data,
    this.errMes,
  });

  @override
  List<Object?> get props => [status, data, errMes];

  DetailsNewsState copyWith({
    ScreenStatus? status,
    NewsDetails? data,
    String? errMes,
  }) {
    return DetailsNewsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errMes: errMes ?? this.errMes,
    );
  }
}
