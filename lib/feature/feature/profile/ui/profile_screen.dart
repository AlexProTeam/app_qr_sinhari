import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/utils/validate_utils.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

import '../../../../common/const/key_save_data_local.dart';
import '../../../../common/local/local_app.dart';
import '../../../../common/utils/common_util.dart';
import '../../../../common/utils/enum_app_status.dart';
import '../../../../re_base/app/di/injector_container.dart';
import '../../../widgets/bottom_sheet_select_image.dart';
import '../../../widgets/follow_keyboard_widget.dart';
import '../bloc/profile_bloc.dart';

Widget get getProfileScreenRoute => BlocProvider(
      create: (context) => ProfileBloc1(),
      child: const ProfileScreen(),
    );

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final ProfileBloc1 _bloc1;

  @override
  void initState() {
    super.initState();
    _bloc1 = context.read<ProfileBloc1>();
    _bloc1.add(InitProfileEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thông tin cá nhân',
        isShowBack: true,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<ProfileBloc1, ProfileState>(
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) async {
          switch (state.statusPost) {
            case StatusPost.loading:
              // await DialogManager.showLoadingDialog(context);
              break;
            case StatusPost.success:
              _nameController.text = state.profileModel?.name ?? '';
              _emailController.text = state.profileModel?.email ?? '';
              _phoneController.text = state.profileModel?.phone ?? '';
              _addressController.text = state.profileModel?.address ?? '';
              ToastManager.showToast(
                context,
                text: 'Cập nhật thông tin thành công!',
                afterShowToast: () => Navigator.pop(context),
              );
              break;
            case StatusPost.failed:
              ToastManager.showToast(
                context,
                text: 'Cập nhật thông tin thất bại!',
                afterShowToast: () => Navigator.pop(context),
              );
              break;
          }
        },
        builder: (context, state) {
          return FollowKeyBoardWidget(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: (state.status == ScreenStatus.loading)
                    ? const Center(
                        heightFactor: 15,
                        child: CircularProgressIndicator(),
                      )
                    : Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                CommonUtil.showCustomBottomSheet(
                                  context: context,
                                  child: BottomSheetSelectImage(
                                    onCameraTap: () => _onSelectImage(true),
                                    onPhotoTap: () => _onSelectImage(false),
                                  ),
                                  height: 250,
                                  onClosed: () {},
                                  backgroundColor: Colors.transparent,
                                );
                              },
                              child: Container(
                                width: 164,
                                height: 164,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xFFD9D9D9),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: _buildProfileImage(state),
                              ),
                            ),
                            const SizedBox(height: 27),
                            CustomTextField(
                              height: 45,
                              hintText: 'Họ và tên',
                              controller: _nameController,
                              validator: ValidateUtil.validEmpty,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 45,
                              hintText: 'Email',
                              validator: ValidateUtil.validEmail,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 45,
                              hintText: 'Số điện thoại',
                              validator: ValidateUtil.validPhone,
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 45,
                              hintText: 'Địa chỉ',
                              controller: _addressController,
                              validator: ValidateUtil.validEmpty,
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              width: 100.44,
                              height: 45,
                              onTap: () => _saveProfile(),
                              text: 'Lưu lại',
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImage(ProfileState state) {
    if (state.image.isNotEmpty) {
      return Image.file(
        File(state.image),
        width: 112,
        height: 112,
        fit: BoxFit.contain,
      );
    } else if (state.profileModel?.avatar?.isEmpty == true) {
      return Stack(
        children: [
          Center(
            child: Image.asset(
              IconConst.logoLogin,
              width: 145,
              height: 145,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  IconConst.camera,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return CustomImageNetwork(
        url: '${state.profileModel?.avatar}',
        width: 112,
        height: 112,
        fit: BoxFit.cover,
      );
    }
  }

  void _onSelectImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      final localApp = injector<LocalApp>();
      localApp.saveBool(
        isCamera
            ? KeySaveDataLocal.havedAcceptPermissionCamera
            : KeySaveDataLocal.havedAcceptPermissionPhoto,
        true,
      );
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) return;

    CommonUtil.dismissKeyBoard(context);
    _bloc1.add(OnClickEvent(
      _nameController.text,
      _emailController.text,
      _phoneController.text,
      _addressController.text,
    ));
  }
}
