import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/route_names.dart';
import 'package:qrcode/presentation/feature/address/widget/address_item_widget.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../app/managers/color_manager.dart';
import '../../../app/managers/status_bloc.dart';
import '../../../app/managers/style_manager.dart';
import '../../widgets/custom_scaffold.dart';
import 'bloc/address_bloc.dart';
import 'detail_edit_address_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late final AddressBloc _addressBloc;

  @override
  void initState() {
    _addressBloc = context.read<AddressBloc>();
    _addressBloc.add(GetListAddressEvent());
    super.initState();
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
      body: BlocConsumer<AddressBloc, AddressState>(
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          state.status == BlocStatusEnum.loading
              ? DialogManager.showLoadingDialog(context)
              : DialogManager.hideLoadingDialog;

          if (state.message.isNotEmpty) {
            ToastManager.showToast(context, text: state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Địa chỉ nhận hàng',
                    style: TextStyleManager.normalBlack.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  13.verticalSpace,

                  /// thêm địa chỉ
                  InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        RouteDefine.detailEditAddressScreen,
                        arguments: DetailEditAddressAgument(
                          detailAddressStatusScreenEnum:
                              DetailAddressStatusScreenEnum.create,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thêm mới địa chỉ',
                          style: TextStyleManager.normalBlack.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(Icons.add),
                      ],
                    ),
                  ),
                  13.verticalSpace,

                  /// list data
                  ...List.generate(
                    state.listAddressResponse.length,
                    (index) {
                      final data = state.listAddressResponse[index];

                      return Dismissible(
                        key: Key(index.toString()),
                        background: Container(
                          color: AppColors.red.withOpacity(0.2),
                          child: const Icon(
                            Icons.delete_forever,
                            color: AppColors.red,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          final result = await DialogManager.showDialogConfirm(
                            context,
                            onTapLeft: () => _addressBloc
                                .add(DeleteAddressEvent(data.id ?? 0)),
                            content: 'Bạn có chắc chắn muốn xóa địa chỉ này',
                            leftTitle: 'Xác nhận',
                          );

                          return result;
                        },
                        child: Column(
                          children: [
                            AddressItemWidget(
                              fullName: data.name ?? '',
                              phoneNumber: data.phone ?? '',
                              address: data.address ?? '',
                              note: data.note ?? '',
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteDefine.detailEditAddressScreen,
                                arguments: DetailEditAddressAgument(
                                  addressData: data,
                                  detailAddressStatusScreenEnum:
                                      DetailAddressStatusScreenEnum.update,
                                ),
                              ),
                            ),
                            4.verticalSpace,
                            const Divider()
                          ],
                        ),
                      );
                    },
                  ),
                  10.verticalSpace,

                  30.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
