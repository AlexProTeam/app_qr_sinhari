part of 'bloc_details_news_bloc.dart';

abstract class DetailsNewsState extends Equatable {
  const DetailsNewsState();
}

class ArgumentDetailNewScreen extends DetailsNewsState {
  final int? newsDetail;
  final String? url;

  const ArgumentDetailNewScreen({this.newsDetail, this.url});

  @override
  // TODO: implement props
  List<Object?> get props => [newsDetail, url];
}

class DetailsNewsInitial extends DetailsNewsState {
  @override
  List<Object> get props => [];
}
