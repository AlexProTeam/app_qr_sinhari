part of 'news_bloc.dart';

class NewsState extends Equatable {
  final ScreenStatus status;
  final List<NewsModelResponse> histories;
  final String mesErr;

  const NewsState({
    this.status = ScreenStatus.loading,
    this.histories = const [],
    this.mesErr = '',
  });

  @override
  List<Object?> get props => [status, histories, mesErr];

  NewsState copyWith({
    ScreenStatus? status,
    List<NewsModelResponse>? histories,
    String? mesErr,
  }) {
    return NewsState(
      status: status ?? this.status,
      histories: histories ?? this.histories,
      mesErr: mesErr ?? this.mesErr,
    );
  }
}
