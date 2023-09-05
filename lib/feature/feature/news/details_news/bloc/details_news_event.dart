part of 'details_news_bloc.dart';

abstract class DetailsNewsEvent extends Equatable {
  const DetailsNewsEvent();
}

class InitDetailsNewsEvent extends DetailsNewsEvent {
  final int arg;

  const InitDetailsNewsEvent(this.arg);

  @override
  List<Object?> get props => [arg];
}
