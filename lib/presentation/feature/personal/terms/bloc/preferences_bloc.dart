import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/model/Introduce_model.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../app/route/common_util.dart';
import '../../../../../app/route/enum_app_status.dart';

part 'preferences_event.dart';

part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc() : super(const PreferencesState()) {
    on<PreferencesEvent>((event, emit) {});
    on<InitDataEvent>((event, emit) async {
      final AppUseCase repository = getIt<AppUseCase>();
      switch (event.arg) {
        case "Screen1":
          try {
            emit(state.copyWith(status: ScreenStatus.loading));
            final data = await repository.getIntroduce();
            emit(state.copyWith(status: ScreenStatus.success, data: data));
          } catch (e) {
            emit(state.copyWith(status: ScreenStatus.failed));
            CommonUtil.handleException(e, methodName: '');
          }
          break;
        case "Screen2":
          try {
            emit(state.copyWith(status: ScreenStatus.loading));
            final data = await repository.getSupport();
            emit(state.copyWith(status: ScreenStatus.success, data: data));
          } catch (e) {
            emit(state.copyWith(status: ScreenStatus.failed));
            CommonUtil.handleException(e, methodName: '');
          }
          break;
        case "Screen3":
          try {
            emit(state.copyWith(status: ScreenStatus.loading));
            final data = await repository.getTerms();
            emit(state.copyWith(status: ScreenStatus.success, data: data));
          } catch (e) {
            emit(state.copyWith(status: ScreenStatus.failed));

            CommonUtil.handleException(e, methodName: '');
          }
          break;
      }
    });
  }
}
