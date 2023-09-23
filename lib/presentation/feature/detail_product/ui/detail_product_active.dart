import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/presentation/feature/detail_product/bloc/product_detail_bloc.dart';
import 'package:qrcode/presentation/feature/detail_product/ui/detail_product_screen.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/custom_textfield.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../../../app/managers/color_manager.dart';
import '../../../../../app/managers/style_manager.dart';
import '../../../../../app/route/validate_utils.dart';
import '../../../../../domain/entity/profile_model.dart';

class ArgumentActiveScreen {
  final int? productId;

  ArgumentActiveScreen({this.productId});
}

class DetailProductActive extends StatefulWidget {
  final ArgumentActiveScreen? argument;

  const DetailProductActive({Key? key, this.argument}) : super(key: key);

  @override
  DetailProductActiveState createState() => DetailProductActiveState();
}

class DetailProductActiveState extends State<DetailProductActive> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adddressController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    ProfileModel? profileModel = context.read<ProfileBloc>().state.profileModel;
    _nameController.text = profileModel?.name ?? '';
    _phoneController.text = profileModel?.phone ?? '';
    _adddressController.text = profileModel?.address ?? '';
    _contentController.text = "Tôi muốn kích hoạt sản phẩm này";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _adddressController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Kích hoạt',
        iconLeftTap: () => Navigator.pop(context),
      ),
      body: BlocProvider(
        create: (context) => ProductDetailBloc(),
        child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
          listener: (BuildContext context, state) {
            switch (state.status) {
              case BlocStatusEnum.success:
                DialogManager.hideLoadingDialog;
                _contentController.clear();
                ToastManager.showToast(
                  context,
                  text: 'Kích hoạt thành công',
                  afterShowToast: () => Navigator.pop(context),
                );
                break;
              case BlocStatusEnum.failed:
                DialogManager.hideLoadingDialog;
                ToastManager.showToast(context, text: 'Kích hoạt thất bại');
                break;
              case BlocStatusEnum.init:
              case BlocStatusEnum.loading:
                DialogManager.showLoadingDialog(context);
                break;
            }
          },
          builder: (context, state) {
            return Padding(
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
                            // validator: ValidateUtil.validEmpty,
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
                            if (_formKey.currentState?.validate() == false) {
                              return;
                            }

                            context.read<ProductDetailBloc>().add(
                                OnClickBuyEvent(
                                    id: widget.argument?.productId ?? 0,
                                    content: _contentController,
                                    appUseCase: getIt<AppUseCase>()));
                          },
                          child: Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: AppConstant.defaultShadow,
                            ),
                            child: Center(
                              child: Text(
                                'Kích hoạt',
                                style: TextStyleManager.normalWhite.copyWith(
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
            );
          },
        ),
      ),
    );
  }
}
