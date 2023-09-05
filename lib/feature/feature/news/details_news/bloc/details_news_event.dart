part of 'details_news_bloc.dart';

abstract class DetailsNewsEvent extends Equatable {
  const DetailsNewsEvent();
}

class InitDetailsNewsEvent extends DetailsNewsEvent {
  final int arg;
  final String url;

  const InitDetailsNewsEvent(this.arg, this.url);

  @override
  List<Object?> get props => [arg, url];
}
