import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/presentation/feature/detail_product/bloc/product_detail_bloc.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/custom_textfield.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../../../app/route/validate_utils.dart';
import '../../../../../domain/entity/profile_model.dart';

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
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Mua hàng',
        isShowBack: true,
      ),
      body: BlocListener<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state.status == BlocStatusEnum.loading) {
            DialogManager.showLoadingDialog(context);
          }
          if (state.status == BlocStatusEnum.success) {
            DialogManager.hideLoadingDialog;
            ToastManager.showToast(
              context,
              text: 'Mua hàng thất bại',
              afterShowToast: () => Navigator.pop(context),
            );
          }

          if (state.status == BlocStatusEnum.failed) {
            DialogManager.hideLoadingDialog;
            ToastManager.showToast(
              context,
              text: 'Mua hàng thành công',
              afterShowToast: () => Navigator.pop(context),
            );
          }
        },
        child: Padding(
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
      ),
    );
  }

  void _initData() async {
    ProfileModel? profileModel = context.read<ProfileBloc>().state.profileModel;
    _nameController.text = profileModel?.name ?? '';
    _phoneController.text = profileModel?.phone ?? '';
    _addressController.text = profileModel?.address ?? '';
    _contentController.text = "Tôi muốn mua hàng";
  }

  void _onDone() async {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProductDetailBloc>().add(OnClickBuyEvent(
        id: widget.argument?.productId ?? 0, content: _contentController));
  }
}
