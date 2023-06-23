abstract class LoadingState {
  final bool? loading;
  final bool? showPopUp;

  LoadingState({this.loading, this.showPopUp});
}

class Loading extends LoadingState {

  Loading() : super(loading: true);
}

class Loaded extends LoadingState {
  Loaded() : super(loading: false);
}

class ShowPopUpState extends LoadingState {
  ShowPopUpState(bool? show) : super(showPopUp: show, loading: false);
}
