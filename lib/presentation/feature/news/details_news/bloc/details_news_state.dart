part of 'details_news_bloc.dart';

class DetailsNewsState extends Equatable {
  final ScreenStatus status;
  final NewsDetails? data;

  const DetailsNewsState({this.status = ScreenStatus.loading, this.data});

  DetailsNewsState copyWith({ScreenStatus? status, NewsDetails? data}) {
    return DetailsNewsState(
        status: status ?? this.status, data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, data];
}
