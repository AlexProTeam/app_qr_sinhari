import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/validate_utils.dart';
import 'package:qrcode/feature/widgets/bottom_sheet_select_image.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

import '../../injector_container.dart';

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
  File? _image;
  bool isLoading = false;

  void _onDone() async {
    CommonUtil.dismissKeyBoard(context);
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() {
        isLoading = true;
      });

      final client = injector<AppClient>();
      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final address = _addressController.text;

      await client.post(
          'auth/saveProfile?name=$name&email=$email&phone=$phone&address=$address');

      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        type: SnackBarType.success,
        content: 'Cập nhật thông tin thành công!',
      ));

      final data = await client.get('auth/showProfile');
      final profileModel = ProfileModel.fromJson(data['data']);
      injector<AppCache>().profileModel = profileModel;
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _chooseTypeImage() {
    CommonUtil.showCustomBottomSheet(
      context: context,
      child: BottomSheetSelectImage(
        onCameraTap: () {
          _onSelectImage(true);
        },
        onPhotoTap: () {
          _onSelectImage(false);
        },
      ),
      height: 180,
      onClosed: () {},
      backgroundColor: Colors.transparent,
    );
  }

  void _onSelectImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      final localApp = injector<LocalApp>();
      if (isCamera) {
        localApp.saveBool(KeySaveDataLocal.havedAcceptPermissionCamera, true);
      } else {
        localApp.saveBool(KeySaveDataLocal.havedAcceptPermissionPhoto, true);
      }

      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    final profileModel = injector<AppCache>().profileModel;
    _nameController.text = profileModel?.name ?? '';
    _emailController.text = profileModel?.email ?? '';
    _phoneController.text = profileModel?.phone ?? '';
    _addressController.text = profileModel?.address ?? '';
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
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: Color(0xFFACACAC),
                      ),
                    ),
                    const Text(
                      'Thông tin cá nhân',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                Expanded(
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
                              onTap: _chooseTypeImage,
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
                                child: _image != null
                                    ? Container(
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
                                        child: Image.file(
                                          _image!,
                                          width: 112,
                                          height: 112,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : ((injector<AppCache>()
                                                .profileModel
                                                ?.avatar
                                                ?.isEmpty ??
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
                                                '${injector<AppCache>().profileModel?.avatar}',
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
                              onTap: _onDone,
                              text: 'Lưu lại',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
