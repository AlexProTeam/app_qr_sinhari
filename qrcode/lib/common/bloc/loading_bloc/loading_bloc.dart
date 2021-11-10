import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  factory LoadingBloc() => _instance;

  LoadingBloc._() : super(Loaded());

  static final LoadingBloc _instance = LoadingBloc._();

  static LoadingBloc get instance => _instance;

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    switch (event.runtimeType) {
      case StartLoading:
        yield Loading();
        break;
      case FinishLoading:
        yield Loaded();
        break;
      case ShowNewYearCardEvent:
        yield ShowPopUpState(event.showNewYear);
        break;
    }
  }
}
