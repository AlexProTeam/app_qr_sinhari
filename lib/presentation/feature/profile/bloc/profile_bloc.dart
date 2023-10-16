import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/data/utils/exceptions/api_exception.dart';

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
          mes: e.message,
        ));
      }
    });

    on<OnClickEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatusEnum.loading));

        final result = event.isHasChangeAvatar
            ? await _appUseCase.saveProfileAvatar(
                name: event.name,
                email: event.mail,
                phone: event.phone,
                address: event.andres,
                avatar: File(state.image),
              )
            : await _appUseCase.saveProfile(
                name: event.name,
                email: event.mail,
                phone: event.phone,
                address: event.andres,
              );

        emit(
          state.copyWith(
            status: BlocStatusEnum.success,
            mes: 'Cập nhật thông tin thành công',
            profileModel: result.data,
          ),
        );
      } on ApiException catch (e) {
        emit(state.copyWith(
          status: BlocStatusEnum.failed,
          mes: e.message,
        ));
      }
    });

    on<OnSelectImageEvent>((event, emit) async {
      emit(state.copyWith(
        image: event.filePath,
        profileModel: state.profileModel,
      ));
    });

    on<ClearProfileEvent>((event, emit) async {
      emit(state.copyWith(
        profileModel: null,
        status: BlocStatusEnum.init,
      ));
    });
  }
}
