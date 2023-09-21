import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';
import 'package:qrcode/domain/all_app_doumain/usecases/app_usecase.dart';

import '../../../../domain/entity/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppUseCase _appUseCase = getIt<AppUseCase>();

  ProfileBloc() : super(const ProfileState()) {
    on<InitProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final data = await _appUseCase.getShowProfile();

        emit(state.copyWith(
          status: BlocStatusEnum.success,
          profileModel: data,
        ));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });

    on<OnClickEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        await _appUseCase.saveProfile(
          name: event.nameController,
          email: event.mailController,
          phone: event.phoneController,
          address: event.andressController,
          avatar: event.imageController.isNotEmpty
              ? File(event.imageController)
              : null,
        );

        emit(state.copyWith(status: BlocStatusEnum.success));
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          errMes: e.message,
        ));
      }
    });

    on<OnSelectImageEvent>((event, emit) async {
      emit(state.copyWith(image: event.filePath));
    });

    on<ClearProfileEvent>((event, emit) async {
      emit(state.copyWith(
        profileModel: ProfileModel(),
      ));
    });
  }
}
