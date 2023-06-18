import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/validate_utils.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

class ArgumentContactScreen {
  final int? productId;

  ArgumentContactScreen({this.productId});
}

class DetailProductContact extends StatefulWidget {
  final ArgumentContactScreen? argument;

  const DetailProductContact({Key? key, this.argument}) : super(key: key);

  @override
  DetailProductContactState createState() => DetailProductContactState();
}

class DetailProductContactState extends State<DetailProductContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    ProfileModel? profileModel = injector<AppCache>().profileModel;
    _nameController.text = profileModel?.name ?? '';
    _phoneController.text = profileModel?.phone ?? '';
    _addressController.text = profileModel?.address ?? '';
    _contentController.text = "Tôi muốn mua hàng";
  }

  void _onDone() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      setState(() {
        isLoading = true;
      });

      await injector<AppClient>().post(
          'save-contact?product_id=${widget.argument?.productId}&content=${_contentController.text}&type=0');

      injector<SnackBarBloc>().add(
        ShowSnackbarEvent(
          type: SnackBarType.success,
          content: 'Mua hàng thành công',
        ),
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      CommonUtil.handleException(
        injector<SnackBarBloc>(),
        e,
        methodName: 'getThemes CourseCubit',
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Mua hàng',
        iconLeftTap: () => Navigator.pop(context),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Họ và tên',
                            controller: _nameController,
                            validator: ValidateUtil.validEmpty,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            texts: false,
                            hintText: 'Số điện thoại',
                            validator: ValidateUtil.validPhone,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hintText: 'Địa chỉ',
                            controller: _addressController,
                            validator: ValidateUtil.validEmpty,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hintText: 'Nội dung',
                            controller: _contentController,
                            validator: ValidateUtil.validEmpty,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _onDone();
                            _contentController.clear();
                          },
                          child: Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: StringConst.defaultShadow,
                            ),
                            child: Center(
                              child: Text(
                                'Lưu lại',
                                style: AppTextTheme.normalWhite.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
