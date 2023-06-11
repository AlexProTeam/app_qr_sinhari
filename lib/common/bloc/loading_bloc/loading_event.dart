abstract class LoadingEvent {
  final bool? showNewYear;

  LoadingEvent({this.showNewYear});
}

class StartLoading extends LoadingEvent {
  StartLoading();
}

class FinishLoading extends LoadingEvent {}

class ShowNewYearCardEvent extends LoadingEvent {
  ShowNewYearCardEvent({required bool showPopUp})
      : super(showNewYear: showPopUp);
}
