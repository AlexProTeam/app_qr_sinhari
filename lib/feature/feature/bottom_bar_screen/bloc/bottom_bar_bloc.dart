// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../enum/bottom_bar_enum.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarState.initial()) {
    on<BottomBarEvent>((event, emit) {});

    on<ChangeTabBottomBarEvent>((event, emit) {
      emit(BottomBarState(bottomBarEnum: event.bottomBarEnum));
    });
  }
}
