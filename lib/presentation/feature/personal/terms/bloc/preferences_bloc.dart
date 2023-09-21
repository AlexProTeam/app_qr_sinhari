import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/domain/entity/Introduce_model.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';

import '../../../../../app/di/injection.dart';
import '../../../../../data/utils/exceptions/api_exception.dart';
import '../../enum/personal_menu_enum.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final AppUseCase repository = getIt<AppUseCase>();

  PreferencesBloc() : super(const PreferencesState()) {
    on<PreferencesEvent>((event, emit) {});
    on<InitPreferencesEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final data =
            await repository.getSupportPolicy(event.policyEnum.getScreenTerms);

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          data: data,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          mesErr: e.message,
        ));
      }
    });
  }
}
