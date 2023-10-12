import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/presentation/feature/detail_product/bloc/product_detail_bloc.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/input_custom.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../../../app/route/validate_utils.dart';
import '../../../../../domain/entity/profile_model.dart';

class DetailProductContact extends StatefulWidget {
  final int? productId;

  const DetailProductContact({Key? key, this.productId}) : super(key: key);

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
          if (state.status == BlocStatusEnum.failed) {
            DialogManager.hideLoadingDialog;
            ToastManager.showToast(
              context,
              text: 'Mua hàng thất bại',
              afterShowToast: () => Navigator.pop(context),
            );
          }

          if (state.status == BlocStatusEnum.success) {
            DialogManager.hideLoadingDialog;
            ToastManager.showToast(
              context,
              text: 'Mua hàng thành công',
              afterShowToast: () => Navigator.pop(context),
            );
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  MBPTextField(
                    title: 'Nhập họ và tên',
                    hint: 'Họ và tên',
                    controller: _nameController,
                    onChanged: (_) {},
                    validator: ValidateUtil.validEmpty,
                  ),
                  MBPTextField(
                    title: 'Nhập số điện thoại',
                    hint: 'Số điện thoại',
                    controller: _phoneController,
                    onChanged: (_) {},
                    validator: ValidateUtil.validPhone,
                    keyboardType: TextInputType.phone,
                  ),
                  MBPTextField(
                    title: 'Nhập địa chỉ',
                    hint: 'Địa chỉ',
                    controller: _addressController,
                    onChanged: (_) {},
                    validator: ValidateUtil.validEmpty,
                  ),
                  MBPTextField(
                    title: 'Nhập nội dung',
                    hint: 'Nội dung',
                    controller: _contentController,
                    onChanged: (_) {},
                    validator: ValidateUtil.validEmpty,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(width: 150, text: 'Lưu lại', onTap: _onDone),
                  const SizedBox(height: 100),
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
    context.read<ProductDetailBloc>().add(
          OnClickBuyEvent(
            id: widget.productId ?? 0,
            content: _contentController,
          ),
        );
  }
}
