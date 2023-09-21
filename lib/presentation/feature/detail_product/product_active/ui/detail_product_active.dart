import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:qrcode/presentation/widgets/dialog_manager_custom.dart';

import '../../../../../app/managers/color_manager.dart';
import '../../../../../app/managers/const/string_const.dart';
import '../../../../../app/managers/style_manager.dart';
import '../../../../../app/route/validate_utils.dart';
import '../../../../../domain/entity/profile_model.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/toast_manager.dart';
import '../bloc/details_product_active_bloc.dart';

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
  bool isLoadding = false;

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
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Kích hoạt',
        iconLeftTap: () => Navigator.pop(context),
      ),
      body: BlocProvider(
        create: (context) => DetailsProductActiveBloc(),
        child: BlocConsumer<DetailsProductActiveBloc, DetailsProductState>(
          listener: (BuildContext context, DetailsProductState state) {
            switch (state.status) {
              case BlocStatusEnum.success:
                DialogManager.hideLoadingDialog;
                ToastManager.showToast(context, text: 'Kích hoạt thành công');
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
                            DetailsProductActiveBloc().add(
                                InitDetailsProductEvent(
                                    widget.argument?.productId ?? 0,
                                    _contentController,
                                    _formKey));
                            if (mounted &&
                                state.status == BlocStatusEnum.success) {
                              ToastManager.showToast(context,
                                  text: 'Kích hoạt thành công');
                            }
                            if (!mounted &&
                                state.status == BlocStatusEnum.failed) {
                              Navigator.pop(context);
                            }
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
