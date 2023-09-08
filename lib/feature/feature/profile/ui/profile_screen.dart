import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/utils/validate_utils.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
import 'package:qrcode/feature/widgets/follow_keyboard_widget.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

import '../../../../common/utils/enum_app_status.dart';
import '../bloc/profile_bloc.dart';

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

  // File? _image;
  @override
  void initState() {
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
      body: BlocProvider(
        create: (context) => ProfileBloc1()..add(InitProfileEvent()),
        child: BlocConsumer<ProfileBloc1, ProfileState>(
          listener: (context, state) {
            switch (state.statusPost) {
              case StatusPost.loading:
                const Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case StatusPost.success:
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
            _nameController.text = state.profileModel?.name ?? '';
            _emailController.text = state.profileModel?.email ?? '';
            _phoneController.text = state.profileModel?.phone ?? '';
            _addressController.text = state.profileModel?.address ?? '';
            print(state.image);
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
                                  BlocProvider.of<ProfileBloc1>(context)
                                      .add(OnChooseImageEvent(context));
                                  setState(() {});
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
                                  child: state.image.isNotEmpty
                                      ? Container(
                                          width: 164,
                                          height: 164,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: const Color(0xFFD9D9D9),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: Image.file(
                                            // File(
                                            //     '/Users/macbook2020/Library/Developer/CoreSimulator/Devices/F38135A9-8DA1-4CD6-9944-347B2D41AD78/data/Containers/Data/Application/A71E514C-558E-4C5C-A17B-BE667EE7B3F0/tmp/image_picker_1450B01E-F241-406C-A003-4511969FEA10-91210-0000412F73F39790.jpg'),
                                            File(state.image),
                                            width: 112,
                                            height: 112,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      : ((state.profileModel?.avatar?.isEmpty ??
                                              true)
                                          ? Stack(
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                            )
                                          : CustomImageNetwork(
                                              url:
                                                  '${state.profileModel?.avatar}',
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
                                onTap: () => context.read<ProfileBloc1>()
                                  ..add(OnClickEvent(
                                      context,
                                      _nameController,
                                      _emailController,
                                      _phoneController,
                                      _addressController,
                                      _formKey)),
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
      ),
    );
  }

// void _onDone() async {
//   CommonUtil.dismissKeyBoard(context);
//   if (!_formKey.currentState!.validate()) return;
//   try {
//     await DialogManager.showLoadingDialog(context);
//
//     final client = injector<AppClient>();
//     final name = _nameController.text;
//     final email = _emailController.text;
//     final phone = _phoneController.text;
//     final address = _addressController.text;
//
//     await client.post(
//         'auth/saveProfile?name=$name&email=$email&phone=$phone&address=$address');
//
//     if (mounted) {
//       context.read<ProfileBloc>().add(const InitProfileEvent());
//       DialogManager.hideLoadingDialog;
//       await ToastManager.showToast(
//         context,
//         text: 'Cập nhật thông tin thành công!',
//         afterShowToast: () => Navigator.pop(context),
//       );
//     }
//     return;
//   } catch (e) {
//     CommonUtil.handleException(e, methodName: '');
//   }
//
//   DialogManager.hideLoadingDialog;
//   setState(() {});
// }

// void _chooseTypeImage() {
//   CommonUtil.showCustomBottomSheet(
//     context: context,
//     child: BottomSheetSelectImage(
//       onCameraTap: () {
//         _onSelectImage(true);
//       },
//       onPhotoTap: () {
//         _onSelectImage(false);
//       },
//     ),
//     height: 250,
//     onClosed: () {},
//     backgroundColor: Colors.transparent,
//   );
// }
//
// ///todo: err up img
// void _onSelectImage(bool isCamera) async {
//   final imagePicker = ImagePicker();
//   final image = await imagePicker.pickImage(
//     source: isCamera ? ImageSource.camera : ImageSource.gallery,
//   );
//
//   if (image != null) {
//     final localApp = injector<LocalApp>();
//     if (isCamera) {
//       localApp.saveBool(KeySaveDataLocal.havedAcceptPermissionCamera, true);
//     } else {
//       localApp.saveBool(KeySaveDataLocal.havedAcceptPermissionPhoto, true);
//     }
//
//     setState(() {
//       _image = File(image.path);
//     });
//   }
// }
}
