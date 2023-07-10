import 'package:flutter/material.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/profile_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/validate_utils.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
import 'package:qrcode/feature/widgets/dialog_manager_custom.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

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

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Mua hàng',
        isShowBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Padding(
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
                const SizedBox(height: 30),
                CustomButton(width: 150, text: 'Lưu lại', onTap: _onDone)
              ],
            ),
          ),
        ),
      ),
    );
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
      await DialogManager.showLoadingDialog(context);

      await injector<AppClient>().post(
          'save-contact?product_id=${widget.argument?.productId}&content=${_contentController.text}&type=0');

      if (mounted) {
        await ToastManager.showToast(
          context,
          text: 'Mua hàng thành công',
          afterShowToast: () => Navigator.pop(context),
        );
      }
    } catch (e) {
      if (mounted) {
        await ToastManager.showToast(
          context,
          text: 'Mua hàng thất bại',
          afterShowToast: () => Navigator.pop(context),
        );
      }
    }
    DialogManager.hideLoadingDialog;
  }
}
