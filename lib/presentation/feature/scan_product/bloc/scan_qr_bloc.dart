import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/scan_enum.dart';

part 'scan_qr_event.dart';
part 'scan_qr_state.dart';

class ScanBloc extends Bloc<ScanEvent, int> {
  ScanBloc() : super(ScanTypeEnum.product.index);

  Stream<int> mapEventToState(ScanEvent event) async* {
    if (event is UpdateCurrentIndex) {
      yield event.newIndex;
    }
  }
}
