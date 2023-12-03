import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../../app/utils/common_util.dart';
import '../../../../app/utils/validate_utils.dart';
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
  bool _isHasChangeAvatar = false;

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
                12.verticalSpace,
                GestureDetector(
                  onTap: () => _onSelectImage(),
                  child: Container(
                    width: 112.r,
                    height: 112.r,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.grey5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                    ),
                    child: Center(
                      child: _buildProfileImage(state),
                    ),
                  ),
                ),
                27.verticalSpace,
                CustomTextField(
                  height: 45.h,
                  hintText: 'Họ và tên',
                  controller: _nameController,
                  validator: ValidateUtil.validEmpty,
                ),
                8.verticalSpace,
                CustomTextField(
                  height: 45.h,
                  hintText: 'Email',
                  validator: ValidateUtil.validEmail,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                8.verticalSpace,
                CustomTextField(
                  height: 45.h,
                  hintText: 'Số điện thoại',
                  validator: ValidateUtil.validPhone,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                8.verticalSpace,
                CustomTextField(
                  hintText: 'Địa chỉ',
                  controller: _addressController,
                  validator: ValidateUtil.validEmpty,
                ),
                16.verticalSpace,
                CustomButton(
                  width: 100.w,
                  height: 45.h,
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
      print(111);
      return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(11.r),
        ),
        child: Image.file(
          File(state.image),
          width: 110.r,
          height: 110.r,
          fit: BoxFit.cover,
        ),
      );
    }

    if ((state.profileModel?.avatar ?? '').isNotEmpty) {
      return CustomImageNetwork(
        url: state.profileModel?.getAvatar ?? '',
        width: 110.r,
        height: 110.r,
        fit: BoxFit.cover,
        border: 11.r,
      );
    }
    return Stack(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(11.r),
            ),
            child: Assets.images.logoMain.image(
              width: 110.r,
              height: 110.r,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5.r,
          right: 5.r,
          child: Assets.icons.camera.image(
            width: 24.r,
            height: 24.r,
            fit: BoxFit.cover,
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
        .then((value) {
      if (value != null) {
        _isHasChangeAvatar = true;
        context.read<ProfileBloc>().add(OnSelectImageEvent(value.path));
      }
    });
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
        _isHasChangeAvatar,
      ),
    );
  }
}
