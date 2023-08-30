part of 'bloc_details_news_bloc.dart';

abstract class DetailsNewsEvent extends Equatable {
  const DetailsNewsEvent();
}

class DetailsNewsData extends Equatable {
  final Map data = {};

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
