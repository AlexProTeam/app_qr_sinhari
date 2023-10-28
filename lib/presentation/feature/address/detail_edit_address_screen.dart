import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/validate_utils.dart';
import '../../../app/app.dart';
import '../../../app/managers/color_manager.dart';
import '../../../app/managers/status_bloc.dart';
import '../../../app/managers/style_manager.dart';
import '../../../data/app_all_api/models/request/update_address.dart';
import '../../../domain/entity/address_screen.dart';
import '../../widgets/check_box_custom.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/toast_manager.dart';
import 'bloc/address_bloc.dart';

class DetailEditAddressScreen extends StatefulWidget {
  final DetailEditAddressAgument? detailEditAddressAgument;

  const DetailEditAddressScreen({
    Key? key,
    this.detailEditAddressAgument,
  }) : super(key: key);

  @override
  DetailEditAddressScreenState createState() => DetailEditAddressScreenState();
}

class DetailEditAddressScreenState extends State<DetailEditAddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressControler = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSelected = false;

  @override
  void initState() {
    if (widget.detailEditAddressAgument?.detailAddressStatusScreenEnum ==
        DetailAddressStatusScreenEnum.update) {
      _initializeController();
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressControler.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Địa chỉ nhận hàng',
        backGroundColor: AppColors.color7F2B81,
        isShowBack: true,
        titleColor: AppColors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AddressBloc, AddressState>(
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          state.status == BlocStatusEnum.loading
              ? DialogManager.showLoadingDialog(context)
              : DialogManager.hideLoadingDialog;

          if (state.message.isNotEmpty) {
            ToastManager.showToast(
              context,
              text: state.message,
              afterShowToast: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Địa chỉ nhận hàng',
                        style: TextStyleManager.normalBlack.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      16.verticalSpace,
                      CustomTextField(
                        height: 50.h,
                        hintText: 'Tên người nhận',
                        controller: _nameController,
                        validator: ValidateUtil.validEmpty,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        height: 50.h,
                        hintText: 'Số điện thoại',
                        validator: ValidateUtil.validPhone,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        height: 90.h,
                        hintText: 'Địa chỉ',
                        validator: ValidateUtil.validEmpty,
                        controller: _addressControler,
                      ),
                      8.verticalSpace,
                      CustomTextField(
                        hintText: 'Lưu ý',
                        controller: _noteController,
                        height: 90.h,
                      ),
                      12.verticalSpace,
                      CheckBoxCustom(
                        title: 'Đặt làm địa chỉ mặc định',
                        enable: true,
                        onChanged: (value) {
                          setState(() {
                            _isSelected = !_isSelected;
                          });
                        },
                        value: _isSelected,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomButton(
                      radius: 5.r,
                      width: double.maxFinite,
                      height: 45.h,
                      onTap: _onSaveButtonPressed,
                      text: 'Lưu địa chỉ',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _initializeController() {
    _isSelected =
        widget.detailEditAddressAgument?.addressData?.getIsDefault == true;
    final dataAgu =
        widget.detailEditAddressAgument?.addressData ?? AddressResponse();

    _nameController.text = dataAgu.name ?? '';
    _phoneController.text = dataAgu.phone ?? '';
    _addressControler.text = dataAgu.address ?? '';
    _noteController.text = dataAgu.note ?? '';
  }

  void _onSaveButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    /// create
    if (widget.detailEditAddressAgument?.detailAddressStatusScreenEnum ==
        DetailAddressStatusScreenEnum.create) {
      context.read<AddressBloc>().add(
            CreateAddressEvent(getCUAddressRequest),
          );
      return;
    }

    /// update
    context.read<AddressBloc>().add(
          UpdateAddressEvent(getCUAddressRequest),
        );
  }

  CUAddressRequest get getCUAddressRequest => CUAddressRequest(
        addressId:
            widget.detailEditAddressAgument?.detailAddressStatusScreenEnum ==
                    DetailAddressStatusScreenEnum.update
                ? widget.detailEditAddressAgument?.addressData?.id
                : null,
        name: _nameController.text.isEmpty ? null : _nameController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        address: _addressControler.text.isEmpty ? null : _addressControler.text,
        note: _noteController.text.isEmpty ? null : _noteController.text,
        isDefault: _isSelected ? 1 : 0,
      );
}

enum DetailAddressStatusScreenEnum {
  create,
  update,
}

class DetailEditAddressAgument {
  final AddressResponse? addressData;
  final DetailAddressStatusScreenEnum detailAddressStatusScreenEnum;

  DetailEditAddressAgument({
    this.addressData,
    this.detailAddressStatusScreenEnum = DetailAddressStatusScreenEnum.create,
  });
}
