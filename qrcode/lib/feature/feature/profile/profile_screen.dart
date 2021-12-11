import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
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
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/bottom_sheet_select_image.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../injector_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _adddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;

  void _onDone() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      injector<LoadingBloc>().add(StartLoading());
      await injector<AppClient>()
          .post('auth/saveProfile?name=${_nameController.text}'
              '&email=${_emailController.text}&phone=${_phoneController.text}&'
              'address=${_adddressController.text}');
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
          type: SnackBarType.success,
          content: 'Cập nhật thông tin thành công!.'));
      final data = await injector<AppClient>().get('auth/showProfile');
      ProfileModel profileModel = ProfileModel.fromJson(data['data']);
      injector<AppCache>().profileModel = profileModel;
      Routes.instance.pop();
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  void _onDoneNew() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      injector<LoadingBloc>().add(StartLoading());
      var headers = {
        'Authorization': 'Bearer ${injector<AppClient>().header?.accessToken}'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://admin.sinhairvietnam.vn/api/auth/saveProfile'));
      request.fields.addAll({
        'name': '${_nameController.text}',
        'email': '${_emailController.text}',
        'phone': '${_phoneController.text}',
        'address': '${_adddressController.text}'
      });
      if (_image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('avatar', '${_image?.path}'));
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        injector<SnackBarBloc>().add(ShowSnackbarEvent(
            type: SnackBarType.success,
            content: 'Cập nhật thông tin thành công!.'));
        final data = await injector<AppClient>().get('auth/showProfile');
        ProfileModel profileModel = ProfileModel.fromJson(data['data']);
        injector<AppCache>().profileModel = profileModel;
        Routes.instance.pop();
      }
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
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
        backgroundColor: Colors.transparent);
  }

  void _onSelectImage(bool isCamera) async {
    XFile? image = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      if (isCamera) {
        injector<LocalApp>()
            .saveBool(KeySaveDataLocal.havedAcceptPermissionCamera, true);
      } else {
        injector<LocalApp>()
            .saveBool(KeySaveDataLocal.havedAcceptPermissionPhoto, true);
      }
      _image = File(image.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    ProfileModel? profileModel = injector<AppCache>().profileModel;
    _nameController.text = profileModel?.name ?? '';
    _emailController.text = profileModel?.email ?? '';
    _phoneController.text = profileModel?.phone ?? '';
    _adddressController.text = profileModel?.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Thông tin cá nhân',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 12),
                InkWell(
                  onTap: _chooseTypeImage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(56),
                        child: _image != null
                            ? Image.file(
                                _image!,
                                width: 112,
                                height: 112,
                                fit: BoxFit.cover,
                              )
                            : ((injector<AppCache>()
                                        .profileModel
                                        ?.avatar
                                        ?.isEmpty ??
                                    true)
                                ? Image.asset(
                                    IconConst.logo,
                                    width: 112,
                                    height: 112,
                                    fit: BoxFit.cover,
                                  )
                                : CustomImageNetwork(
                                    url: injector<AppCache>()
                                        .profileModel
                                        ?.avatar,
                                    width: 112,
                                    height: 112,
                                    fit: BoxFit.cover,
                                  )),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Họ và tên',
                  controller: _nameController,
                  validator: ValidateUtil.validEmpty,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Email',
                  validator: ValidateUtil.validEmail,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                    hintText: 'Só điện thoại',
                    validator: ValidateUtil.validPhone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Địa chỉ',
                  controller: _adddressController,
                  validator: ValidateUtil.validEmpty,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: _onDoneNew,
                      text: 'Lưu lại',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
