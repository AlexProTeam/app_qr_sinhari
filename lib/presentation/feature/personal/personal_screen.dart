import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/app/app.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

import '../../../app/managers/color_manager.dart';
import '../../../app/managers/route_names.dart';
import '../../../app/managers/status_bloc.dart';
import '../../../app/utils/common_util.dart';
import '../../auth/login/bloc/login_bloc.dart';
import '../../widgets/box_border_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../bottom_bar_screen/bloc/bottom_bar_bloc.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'enum/personal_contact_enum.dart';
import 'enum/personal_menu_enum.dart';

class PersonalNested extends StatelessWidget {
  const PersonalNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: NestedRouteWrapper(
        onGenerateRoute: Routes.generateDefaultRoute,
        navigationKey: Routes.personalKey,
        initialRoute: BottomBarEnum.caNhan.getRouteNames,
      ),
    );
  }
}

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  PersonalScreenState createState() => PersonalScreenState();
}

class PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Tài khoản'),
      backgroundColor: AppColors.bgrScafold,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 100.h),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          state.status == BlocStatusEnum.loading
              ? DialogManager.showLoadingDialog(context)
              : DialogManager.hideLoadingDialog;

          if (state.mes.isNotEmpty) {
            ToastManager.showToast(
              context,
              delaySecond: 1,
              text: state.mes,
              afterShowToast: () {
                if (state.isDeleteAccount == true) {
                  DialogManager.showDialogConfirm(
                    context,
                    content: 'Bạn có muốn về trang chủ không',
                    leftTitle: 'Xác nhận',
                    onTapLeft: () => context.read<BottomBarBloc>().add(
                          const ChangeTabBottomBarEvent(
                            bottomBarEnum: BottomBarEnum.home,
                            isRefresh: true,
                          ),
                        ),
                  );
                }
              },
            );
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Column(
            children: [
              if (!_isProfileModelNotNull) _buildLoginButton(context),
              20.verticalSpace,
              _buildPersonalContactSection(context),
              15.verticalSpace,
              _buildConnectWithSection(),
              30.verticalSpace,
              if (_isProfileModelNotNull) _buildLogoutButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteDefine.loginScreen,
          arguments: true,
        );
      },
      text: 'Đăng nhập',
      width: 100.w,
    );
  }

  Widget _buildPersonalContactSection(BuildContext context) {
    return boxBorderApp(
      child: Column(
        children: PersonalContactEnum.values.map((e) {
          /// check chưa login
          return !_isProfileModelNotNull &&
                      [
                        PersonalContactEnum.account,
                        PersonalContactEnum.deleteAccount,
                      ].contains(e) ||

                  /// check với đại lý
                  !(context.read<ProfileBloc>().state.profileModel?.isAgency ==
                          true) &&
                      [
                        PersonalContactEnum.infoOrder,
                        PersonalContactEnum.historyDebt
                      ].contains(e)
              ? const SizedBox.shrink()
              : iconTextWidget(
                  onTap: () => e.getOnTap(context),
                  text: e.getDisplayValue,
                  iconWidget: e.getIcon(),
                );
        }).toList(),
      ),
    );
  }

  Widget _buildConnectWithSection() {
    return boxBorderApp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kết nối với Sinhair:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          11.verticalSpace,
          ...AppContact.values.map(
            (e) => iconTextWidget(
              onTap: () => CommonUtil.runUrl(e.getLongContact),
              text: e.getShortContact,
              iconWidget: e.getIcon(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return CustomButton(
      onTap: _onTapLogout,
      text: 'Đăng xuất',
    );
  }

  bool get _isProfileModelNotNull =>
      context.read<ProfileBloc>().state.profileModel != null;

  void _onTapLogout() {
    context.read<ProfileBloc>().add(const ClearProfileEvent());
    SessionUtils.clearLogout;
    context.read<BottomBarBloc>().add(
          const ChangeTabBottomBarEvent(
            bottomBarEnum: BottomBarEnum.home,
            isRefresh: true,
          ),
        );
  }
}
