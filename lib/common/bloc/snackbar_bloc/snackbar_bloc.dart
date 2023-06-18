import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';

class SnackBarBloc extends Bloc<SnackbarEvent, SnackBarState> {
  final duration = const Duration(seconds: 3);

  SnackBarBloc() : super(InitialSnackbarState());

  Stream<SnackBarState> mapEventToState(SnackbarEvent event) async* {
    if (event is ShowSnackbarEvent) {
      yield ShowSnackBarState(
          mess: event.content,
          type: event.type,
          duration: event.duration ?? duration);
    }
  }
}
