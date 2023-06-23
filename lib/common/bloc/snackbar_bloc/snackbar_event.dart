
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';

abstract class SnackbarEvent {}

class ShowSnackbarEvent extends SnackbarEvent {
  String content;
  SnackBarType type;
  Duration? duration;

  ShowSnackbarEvent({
    this.content = 'Đã xảy ra lỗi',
    this.type = SnackBarType.error,
    this.duration,
  });
}
