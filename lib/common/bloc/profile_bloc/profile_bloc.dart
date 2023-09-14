import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/managers/const/status_bloc.dart';
import '../../../data/utils/exceptions/api_exception.dart';
import '../../../domain/entity/profile_model.dart';
import '../../../domain/login/usecases/app_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppUseCase appUseCase;

  ProfileBloc(this.appUseCase) : super(const ProfileState()) {
    on<InitProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final result = await appUseCase.getShowProfile();

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          profileModel: result,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          mesErr: e.errorMessage,
          status: BlocStatusEnum.failed,
        ));
      }
    });

    on<ClearProfileEvent>((event, emit) async {
      emit(state.copyWith(
        profileModel: null,
      ));
    });
  }
}
