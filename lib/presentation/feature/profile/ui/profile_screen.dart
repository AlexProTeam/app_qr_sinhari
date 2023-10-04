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
import '../../../widgets/bottom_sheet_select_image.dart';
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
  late final ProfileBloc _bloc;

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
        listener: (context, state) async {
          switch (state.status) {
            case BlocStatusEnum.loading:
              DialogManager.showLoadingDialog(context);
              break;
            case BlocStatusEnum.success:
              DialogManager.hideLoadingDialog;
              _initControler();
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
        },
        builder: (context, state) {
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
                              color: AppColors.grey5,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: state.image.isNotEmpty
                              ? Container(
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
                                  child: Image.file(
                                    File(state.image),
                                    width: 112,
                                    height: 112,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : ((state.profileModel?.avatar?.isEmpty != true)
                                  ? Stack(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                    )
                                  : CustomImageNetwork(
                                      url: state.profileModel?.avatar,
                                      width: 112,
                                      height: 112,
                                      fit: BoxFit.cover,
                                    )),
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
                        onTap: () {
                          if (!_formKey.currentState!.validate()) return;
                          CommonUtil.dismissKeyBoard(context);
                          _bloc.add(OnClickEvent(
                            _nameController.text,
                            _emailController.text,
                            _phoneController.text,
                            _addressController.text,
                            state.image,
                          ));
                        },
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

  void _onSelectImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    await imagePicker
        .pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
        )
        .then((value) =>
            context.read<ProfileBloc>().add(OnSelectImageEvent(value?.path)));
  }

  void _initControler() {
    _nameController.text = _bloc.state.profileModel?.name ?? '';
    _emailController.text = _bloc.state.profileModel?.email ?? '';
    _phoneController.text = _bloc.state.profileModel?.phone ?? '';
    _addressController.text = _bloc.state.profileModel?.address ?? '';
  }
}
