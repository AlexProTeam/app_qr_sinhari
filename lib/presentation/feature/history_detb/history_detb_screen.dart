import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/presentation/feature/history_detb/bloc/history_debt_bloc.dart';
import 'package:qrcode/presentation/feature/history_detb/widget/detb_tab_widget.dart';
import 'package:qrcode/presentation/feature/history_detb/widget/withdrawals_tab_widget.dart';
import 'package:qrcode/presentation/widgets/custom_button.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../app/managers/status_bloc.dart';

class HistoryDetbScreen extends StatefulWidget {
  const HistoryDetbScreen({Key? key}) : super(key: key);

  @override
  State<HistoryDetbScreen> createState() => _HistoryDetbScreenState();
}

class _HistoryDetbScreenState extends State<HistoryDetbScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryDebtBloc()..add(InitDebtEvent()),
      child: BlocConsumer<HistoryDebtBloc, HistoryDebtState>(
        listener: (context, state) {
          state.status == BlocStatusEnum.loading
              ? DialogManager.showLoadingDialog(context)
              : DialogManager.hideLoadingDialog;

          if (state.message.isNotEmpty) {
            ToastManager.showToast(
              context,
              text: state.message,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: BaseAppBar(
              title: 'Lịch sử công nợ',
              backGroundColor: AppColors.color7F2B81,
              isShowBack: true,
              titleColor: AppColors.white,
            ),
            body: Column(
              children: [
                8.verticalSpace,
                ValueListenableBuilder<int>(
                  valueListenable: _valueNotifier,
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        backGroupColor: value == 0 ? null : Colors.grey,
                        width: 100.w,
                        text: 'Công nợ',
                        radius: 6.r,
                        onTap: () => _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.linear),
                      ),
                      10.horizontalSpace,
                      CustomButton(
                        backGroupColor: value == 1 ? null : Colors.grey,
                        width: 100.w,
                        text: 'Thanh toán',
                        radius: 6.r,
                        onTap: () => _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.linear),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      DetbsTabWidget(debts: state.debtModel?.debts ?? []),
                      WithdrawalsTabWidget(
                          withdrawals: state.debtModel?.withdrawals ?? []),
                    ],
                    onPageChanged: (index) => _valueNotifier.value = index,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
