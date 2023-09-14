import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/presentation/auth/welcome/welcome_model.dart';

import '../../../../app/managers/const/status_bloc.dart';
import '../../../../data/utils/exceptions/api_exception.dart';
import '../../../../domain/login/usecases/app_usecase.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final AppUseCase appUseCase;

  WelcomeBloc(this.appUseCase) : super(const WelcomeState()) {
    on<WelcomeEvent>((event, emit) {});

    on<InitWelcomeEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));
        final data = await appUseCase.getImageIntroduction();

        emit(state.copyWith(
          welcomeModel: data,
          status: BlocStatusEnum.success,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });
  }
}
