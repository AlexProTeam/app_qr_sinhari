import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/core/string_ex.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/presentation/feature/pay_debt/bloc/pay_debt_bloc.dart';
import 'package:qrcode/presentation/feature/pay_debt/pay_debt_qr_screen.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/input_custom.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

class PayDebt extends StatefulWidget {
  const PayDebt({Key? key}) : super(key: key);

  @override
  State<PayDebt> createState() => _PayDebtState();
}

class _PayDebtState extends State<PayDebt> {
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thanh toán Công nợ',
        isShowBack: true,
      ),
      body: BlocProvider(
        create: (context) => PayDebtBloc(),
        child: BlocConsumer<PayDebtBloc, PayDebtState>(
          listener: (context, state) {
            switch (state.status) {
              case BlocStatusEnum.loading:
                DialogManager.showLoadingDialog(context);
                break;
              case BlocStatusEnum.success:
                DialogManager.hideLoadingDialog;
                if (state.payment != null) {
                  Navigator.pushNamed(context, RouteDefine.payDebtQrScreen,
                      arguments: ArgumentPayDebtQrScreen(
                          state.payment, amountController.text));
                }
                break;
              case BlocStatusEnum.failed:
                DialogManager.hideLoadingDialog;
                ToastManager.showToast(context, text: state.errMes ?? '');
                break;
              default:
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                30.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MBPTextField(
                    keyboardType: TextInputType.phone,
                    controller: amountController,
                    title: 'Nhập số tiền thanh toán',
                    isRequired: true,
                    onChanged: (_) {},
                  ),
                ),
                CustomButton(
                  radius: 6.r,
                  width: 170.w,
                  text: 'Gửi thanh toán',
                  onTap: () {
                    if (amountController.text.isEmpty) {
                      ToastManager.showToast(context,
                          text: 'Chưa nhập số tiền cần thanh toán');
                      return;
                    }
                    RegExp regex = RegExp(r'[a-zA-Z]');

                    if (regex.hasMatch(amountController.text)) {
                      ToastManager.showToast(context,
                          text: 'Số tiền không hợp lệ');
                      return;
                    }

                    DialogManager.showDialogConfirm(context,
                        onTapLeft: () => context
                            .read<PayDebtBloc>()
                            .add(InitDataPayEvent(amountController.text)),
                        content:
                            'Xác nhận thanh toán số tiền ${amountController.text.toAppNumberFormatWithNull}đ?',
                        leftTitle: 'Thanh toán');
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
