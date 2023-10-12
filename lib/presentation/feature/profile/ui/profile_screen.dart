import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../../app/route/common_util.dart';
import '../../../../app/route/validate_utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_network.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/follow_keyboard_widget.dart';
import '../../../widgets/toast_manager.dart';
import '../bloc/profile_bloc.dart';

Widget get getProfileScreenRoute => BlocProvider(
    create: (BuildContext context) => ProfileBloc(),
    child: const ProfileScreen());

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
  late ProfileBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<ProfileBloc>();
    if ((_bloc.state.profileModel?.phone ?? '').isEmpty) {
      _bloc.add(InitProfileEvent());
    }
    super.initState();
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
      body: BlocConsumer<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) => _handleBlocState(context, state),
        builder: (context, state) => _buildBody(context, state),
      ),
    );
  }

  void _handleBlocState(BuildContext context, ProfileState state) async {
    switch (state.status) {
      case BlocStatusEnum.loading:
        DialogManager.showLoadingDialog(context);
        break;
      case BlocStatusEnum.success:
        DialogManager.hideLoadingDialog;
        _initializeController();
        if (state.mes.isNotEmpty) {
          ToastManager.showToast(
            context,
            text: state.mes,
          );
        }
        break;
      case BlocStatusEnum.failed:
        DialogManager.hideLoadingDialog;
        ToastManager.showToast(
          context,
          text: state.mes,
          afterShowToast: () => Navigator.pop(context),
        );
        break;
      default:
    }
  }

  Widget _buildBody(BuildContext context, ProfileState state) {
    return FollowKeyBoardWidget(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _onSelectImage(),
                  child: Container(
                    width: 164,
                    height: 164,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.grey5,
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
                  onTap: _onSaveButtonPressed,
                  text: 'Lưu lại',
                ),
              ],
            ),
          ),
        ),
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
    }

    if ((state.profileModel?.avatar ?? '').isNotEmpty) {
      return CustomImageNetwork(
        url: state.profileModel?.getAvatar ?? '',
        width: 112,
        height: 112,
        fit: BoxFit.cover,
      );
    }
    return Stack(
      children: [
        Center(
          child: Assets.images.logoMain.image(
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
              Assets.icons.camera.image(
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onSelectImage() async {
    final imagePicker = ImagePicker();
    await imagePicker
        .pickImage(
          source: ImageSource.gallery,
        )
        .then((value) =>
            context.read<ProfileBloc>().add(OnSelectImageEvent(value?.path)));
  }

  void _initializeController() {
    _nameController.text = _bloc.state.profileModel?.name ?? '';
    _emailController.text = _bloc.state.profileModel?.email ?? '';
    _phoneController.text = _bloc.state.profileModel?.phone ?? '';
    _addressController.text = _bloc.state.profileModel?.address ?? '';
  }

  void _onSaveButtonPressed() {
    if (!_formKey.currentState!.validate()) return;
    CommonUtil.dismissKeyBoard(context);
    _bloc.add(
      OnClickEvent(
        _nameController.text,
        _emailController.text,
        _phoneController.text,
        _addressController.text,
        _bloc.state.image,
      ),
    );
  }
}
