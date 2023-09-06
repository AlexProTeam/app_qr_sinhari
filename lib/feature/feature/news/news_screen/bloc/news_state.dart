part of 'news_bloc.dart';

class NewsState extends Equatable {
  final ScreenStatus status;
  final List<NewsModel> histories;

  const NewsState({this.status = ScreenStatus.loading, this.histories = const []});

  NewsState copyWith({
    ScreenStatus? status,
    List<NewsModel>? histories
  }) {
    return NewsState(
      status: status ?? this.status,
      histories: histories ?? this.histories
    );
  }

  @override
  List<Object?> get props => [status, histories];
}
