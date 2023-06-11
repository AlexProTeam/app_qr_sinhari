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
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
class ArgumentActiveScreen {
  final int? productId;

  ArgumentActiveScreen({this.productId});
}
class DetailProductActive extends StatefulWidget {
  final ArgumentActiveScreen? argument;

  const DetailProductActive({Key? key, this.argument}) : super(key: key);

  @override
  _DetailProductActiveState createState() => _DetailProductActiveState();
}

class _DetailProductActiveState extends State<DetailProductActive> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _adddressController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoadding = false;

  void _onDone() async {
    try {
      if (!CommonUtil.validateAndSave(_formKey)) return;
      isLoadding =true;
      await injector<AppClient>().post(
          'save-contact?product_id=${widget.argument?.productId}&content=${_contentController.text}&type=1');
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
          type: SnackBarType.success, content: 'Kích hoạt thành công'));
      Navigator.pop(context);
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes CourseCubit');
    } finally {
      isLoadding =false;
    }

    print("_______");
    print(widget.argument?.productId);

  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async{
    ProfileModel? profileModel = injector<AppCache>().profileModel;
    _nameController.text = profileModel?.name ?? '';
    _phoneController.text = profileModel?.phone ?? '';
    _adddressController.text = profileModel?.address ?? '';
    _contentController.text = "Tôi muốn kích hoạt sản phẩm này";
  }

  @override

  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Kích hoạt',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body:isLoadding
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child:  Form(
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
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Địa chỉ',
                      controller: _adddressController,
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
                  CustomGestureDetector(
                    onTap: (){
                      _onDone();
                      _contentController.clear();
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: StringConst.defaultShadow),
                      child: Center(
                        child: Text(
                          'Kích hoạt',
                          style: AppTextTheme.normalWhite.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
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
