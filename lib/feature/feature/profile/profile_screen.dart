import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/bottom_sheet_select_image.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

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
  bool isLoadding = false;

  void _onDone() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      isLoadding = true;
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
      isLoadding = false;
    }
  }

  void _onDoneNew() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    try {
      isLoadding = true;
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
      isLoadding = false;
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
    print("--------------");
    print("${injector<AppCache>().profileModel?.avatar}");
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
      // customAppBar: CustomAppBar(
      //   title: 'Thông tin cá nhân',
      //   iconLeftTap: () {
      //     Routes.instance.pop();
      //   },
      // ),
      resizeToAvoidBottomInset: false,
      body: isLoadding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Color(0xFFACACAC),
                        )),
                    Text(
                      'Thông tin cá nhân',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                                  Container(
                                    width: 164,
                                    height: 164,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Color(0xFFD9D9D9)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(
                                        12,
                                      )),
                                    ),
                                    child: _image != null
                                        ? Container(
                                            width: 164,
                                            height: 164,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFFD9D9D9)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                12,
                                              )),
                                            ),
                                            child: Image.file(
                                              _image!,
                                              width: 112,
                                              height: 112,
                                              fit: BoxFit.contain,
                                            ))
                                        : ((injector<AppCache>()
                                                    .profileModel
                                                    ?.avatar
                                                    ?.isEmpty ??
                                                true)
                                            ? Stack(
                                                children: [
                                                  Center(
                                                    child: Image.asset(
                                                      IconConst.Logo,
                                                      width: 145,
                                                      height: 145,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Image.asset(
                                                          IconConst.Camera,
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
                                  )
                                ],
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
                                hintText: 'Só điện thoại',
                                validator: ValidateUtil.validPhone,
                                controller: _phoneController,
                                keyboardType: TextInputType.phone),
                            const SizedBox(height: 8),
                            CustomTextField(
                              height: 45,
                              hintText: 'Địa chỉ',
                              controller: _adddressController,
                              validator: ValidateUtil.validEmpty,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  width: 100.44,
                                  height: 45,
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
                ),
              ],
            ),
    );
  }
}
