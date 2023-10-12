import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/presentation/feature/pay_debt/bloc/pay_debt_bloc.dart';
import 'package:qrcode/presentation/feature/pay_debt/pay_debt_qr_screen.dart';
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
                if ((state.payment != null)) {
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
                GestureDetector(
                  onTap: () {
                    if (amountController.text.isEmpty) return;

                    context
                        .read<PayDebtBloc>()
                        .add(InitDataPayEvent(amountController.text));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.red,
                    ),
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 16, top: 16),
                    child: Text(
                      'Gửi thanh toán',
                      style: TextStyleManager.mediumBlack14px.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.white),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
