part of 'details_news_bloc.dart';

class DetailsNewsState extends Equatable {
  final ScreenStatus status;
  final Map data;

  const DetailsNewsState({this.status = ScreenStatus.loading, this.data = const {}});

  DetailsNewsState copyWith({ScreenStatus? status, Map? data}) {
    return DetailsNewsState(
        status: status ?? this.status, data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, data];
}