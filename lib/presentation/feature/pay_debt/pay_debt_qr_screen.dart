import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/feature/pay_debt/bloc/pay_debt_bloc.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/input_custom.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../domain/entity/payment_debt_model.dart';

class ArgumentPayDebtQrScreen {
  final PaymentDebt? payment;
  final String? amount;

  ArgumentPayDebtQrScreen(this.payment, this.amount);
}

class PayDebtQrScreen extends StatefulWidget {
  final ArgumentPayDebtQrScreen? payment;

  const PayDebtQrScreen({Key? key, this.payment}) : super(key: key);

  @override
  State<PayDebtQrScreen> createState() => _PayDebtQrScreenState();
}

class _PayDebtQrScreenState extends State<PayDebtQrScreen> {
  TextEditingController nameBank = TextEditingController();
  TextEditingController numberBank = TextEditingController();
  TextEditingController content = TextEditingController();
  String image = '';
  String description = '';
  int _secondsRemaining = AppConstant.timerPaymentReload;
  late Timer timer;

  @override
  void initState() {
    nameBank.text = widget.payment?.payment?.bankName ?? '';
    numberBank.text = widget.payment?.payment?.accountNumber ?? '';
    content.text = widget.payment?.payment?.contentTranfer ?? '';
    image = widget.payment?.payment?.imageQr ?? '';
    description = widget.payment?.payment?.description ?? '';
    _startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    nameBank.dispose();
    numberBank.dispose();
    content.dispose();
    timer.cancel();
    super.dispose();
  }

  void _startCountdown() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            if (_secondsRemaining > 0) {
              _secondsRemaining--;
            } else {
              _secondsRemaining = AppConstant.timerPaymentReload;
              context
                  .read<PayDebtBloc>()
                  .add(InitDataPayEvent(widget.payment?.amount ?? ''));
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thanh toán Công nợ',
        isShowBack: true,
      ),
      body: BlocConsumer<PayDebtBloc, PayDebtState>(
        listener: (context, state) {
          nameBank.text = state.payment?.bankName ?? '';
          numberBank.text = state.payment?.accountNumber ?? '';
          content.text = state.payment?.contentTranfer ?? '';
          image = state.payment?.imageQr ?? '';
          description = state.payment?.description ?? '';
          if (state.status == BlocStatusEnum.loading) {
            DialogManager.showLoadingDialog(context);
          } else if (state.status == BlocStatusEnum.success &&
              state.data?.success == true) {
            DialogManager.hideLoadingDialog;
            DialogManager.showDialogConfirm(context,
                onTapLeft: () => {},
                content: 'Cảm ơn bạn đã xác nhận thanh toán',
                leftTitle: 'Ok');
          } else {
            DialogManager.hideLoadingDialog;
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                if (image.isNotEmpty)
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: 250.r,
                    height: 250.r,
                  ),
                10.verticalSpace,
                Text(
                  description,
                  style: TextStyleManager.mediumBlack14px.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12.sp,
                    color: AppColors.color000AFF,
                  ),
                ),
                15.verticalSpace,
                rootView(
                    textEditingController: nameBank,
                    title: 'Ngân hàng',
                    hint: '',
                    onTap: () async {
                      await onTap(
                          nameBank.text, context, 'Copy ngân hàng thành công');
                    }),
                rootView(
                    textEditingController: numberBank,
                    title: 'Số tài khoản',
                    hint: '',
                    onTap: () async {
                      await onTap(
                          numberBank.text, context, 'Copy stk thành công');
                    }),
                rootView(
                    textEditingController: content,
                    title: 'Nội dung chuyển khoản',
                    hint: '',
                    onTap: () async {
                      await onTap(
                          content.text, context, 'Copy nội dung thành công');
                    }),
                CustomButton(
                  width: 150.w,
                  text: 'Đã thanh toán',
                  radius: 6.r,
                  onTap: () {
                    context
                        .read<PayDebtBloc>()
                        .add(OnClickPayEvent(payment: widget.payment?.payment));
                  },
                ),
                120.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rootView({
    required TextEditingController textEditingController,
    String? title,
    String? hint,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          Expanded(
            child: MBPTextField(
              controller: textEditingController,
              hint: hint,
              title: title,
              textTitleStyle: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: AppColors.red),
              textStyle: TextStyleManager.mediumBlack14px.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: AppColors.red),
              readOnly: true,
              onChanged: (_) {},
            ),
          ),
          8.horizontalSpace,
          Image.asset(
            Assets.icons.icCopy.path,
            width: 30.w,
            height: 36.h,
          )
        ],
      ),
    );
  }

  onTap(String text, BuildContext context, String title) {
    Clipboard.setData(ClipboardData(text: text));
    ToastManager.showToast(
      context,
      text: title,
    );
  }
}
