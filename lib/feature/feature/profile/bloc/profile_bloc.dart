import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/utils/enum_app_status.dart';

import '../../../../common/const/key_save_data_local.dart';
import '../../../../common/local/local_app.dart';
import '../../../../common/model/profile_model.dart';
import '../../../../common/network/client.dart';
import '../../../../common/utils/common_util.dart';
import '../../../../re_base/app/di/injector_container.dart';
import '../../../widgets/bottom_sheet_select_image.dart';
import '../../../widgets/dialog_manager_custom.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc1 extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc1() : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) {});
    on<InitProfileEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ScreenStatus.loading));

        String? accessToken = injector<LocalApp>()
            .getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
        AppHeader appHeader = AppHeader();
        appHeader.accessToken = accessToken;
        injector<AppClient>().header = appHeader;

        final data = await injector<AppClient>().get('auth/showProfile');
        ProfileModel profileModel = ProfileModel.fromJson(data['data']);

        emit(state.copyWith(
          status: ScreenStatus.success,
          profileModel: profileModel,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ScreenStatus.failed,
        ));
        CommonUtil.handleException(e, methodName: '');
      }
    });
    on<OnClickEvent>((event, emit) async {
      CommonUtil.dismissKeyBoard(event.context);
      if (!event.formKey.currentState!.validate()) return;
      try {
        await DialogManager.showLoadingDialog(event.context);
        emit(state.copyWith(statusPost: StatusPost.loading));

        final client = injector<AppClient>();
        final name = event.nameController.text;
        final email = event.mailController.text;
        final phone = event.phoneController.text;
        final address = event.andressController.text;

        await client.post(
            'auth/saveProfile?name=$name&email=$email&phone=$phone&address=$address');
        emit(state.copyWith(statusPost: StatusPost.success));
        if (event.context.mounted) {
          ProfileBloc1().add(InitProfileEvent());
          DialogManager.hideLoadingDialog;
        }
      } catch (e) {
        emit(state.copyWith(statusPost: StatusPost.failed));
        CommonUtil.handleException(e, methodName: '');
      }
      DialogManager.hideLoadingDialog;
    });
    on<OnSelectImageEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      File image;
      final imagePick = await imagePicker.pickImage(
        source: event.isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      try {
        if (imagePick != null) {
          final localApp = injector<LocalApp>();
          if (event.isCamera) {
            localApp.saveBool(
                KeySaveDataLocal.havedAcceptPermissionCamera, true);
          } else {
            localApp.saveBool(
                KeySaveDataLocal.havedAcceptPermissionPhoto, true);
          }

          // image = File(imagePick.path);
          emit(state.copyWith(image: imagePick.path));
          print(imagePick.path);
        }
      } catch (e) {
        CommonUtil.handleException(e, methodName: '');
      }
    });
    on<OnChooseImageEvent>((event, emit) async {
      CommonUtil.showCustomBottomSheet(
        context: event.context,
        child: BottomSheetSelectImage(
          onCameraTap: () {
            ProfileBloc1().add(const OnSelectImageEvent(true));
          },
          onPhotoTap: () {
            ProfileBloc1().add(const OnSelectImageEvent(false));
          },
        ),
        height: 250,
        onClosed: () {},
        backgroundColor: Colors.transparent,
      );
    });
  }
}
