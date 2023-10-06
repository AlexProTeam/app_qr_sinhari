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
          } else {
            DialogManager.hideLoadingDialog;
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (image.isNotEmpty)
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: 164,
                    height: 175,
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  style: TextStyleManager.mediumBlack14px.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.color000AFF),
                ),
                30.verticalSpace,
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
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.red,
                    ),
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 16, top: 16),
                    child: Text(
                      'Đã thanh toán',
                      style: TextStyleManager.mediumBlack14px.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rootView(
      {required TextEditingController textEditingController,
      String? title,
      String? hint,
      required Function onTap}) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 75,
          child: MBPTextField(
            controller: textEditingController,
            hint: hint,
            title: title,
            textTitleStyle: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColors.red),
            textStyle: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColors.red),
            readOnly: true,
            onChanged: (_) {},
          ),
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Image.asset(
            Assets.icons.icCopy.path,
            width: 43,
            height: 36,
          ),
        )
      ],
    );
  }
}

onTap(String text, BuildContext context, String title) {
  Clipboard.setData(ClipboardData(text: text));
  ToastManager.showToast(
    context,
    text: title,
  );
}
