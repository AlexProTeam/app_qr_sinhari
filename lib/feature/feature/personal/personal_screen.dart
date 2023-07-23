import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/common/const/key_save_data_local.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';

import '../../../common/bloc/profile_bloc/profile_bloc.dart';
import '../../../common/utils/common_util.dart';
import '../../routes.dart';
import '../../themes/theme_color.dart';
import '../../widgets/box_border_widget.dart';
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
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateBottomBarRoute,
      navigationKey: Routes.personalKey,
      initialRoute: BottomBarEnum.caNhan.getRouteNames,
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
      appBar: BaseAppBar(
        title: 'Tài khoản',
      ),
      backgroundColor: AppColors.bgrScafold,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!_isProfileModelNotBull) ...[
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.loginScreen,
                    arguments: true,
                  );
                },
                text: 'Đăng nhập',
                width: 128,
                height: 45,
              ),
              const SizedBox(
                height: 18,
              ),
            ],
            boxBorderApp(
              child: Column(
                children: PersonalContactEnum.values
                    .map(
                      (e) => !_isProfileModelNotBull &&
                              e == PersonalContactEnum.account
                          ? const SizedBox.shrink()
                          : iconTextWidget(
                              onTap: () => e.getOnTap(context),
                              text: e.getDisplayValue,
                              iconWidget: e.getIcon(),
                            ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            boxBorderApp(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kết nối với Sinhair:',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 11),
                  ...AppContact.values.map(
                    (e) => iconTextWidget(
                      onTap: () => CommonUtil.runUrl(e.getLongContact),
                      text: e.getShortContact,
                      iconWidget: e.getIcon(),
                      iconData: '',
                    ),
                  ),
                ],
              ),
            ),
            if (_isProfileModelNotBull) ...[
              const SizedBox(height: 50),
              CustomButton(
                onTap: _onTapLogout,
                text: 'Đăng xuất',
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool get _isProfileModelNotBull =>
      context.read<ProfileBloc>().state.profileModel != null;

  void _onTapLogout() async {
    context.read<ProfileBloc>().add(const ClearProfileEvent());
    injector<AppCache>().havedLogin = false;
    await injector<LocalApp>()
        .saveStringSharePreference(KeySaveDataLocal.keySaveAccessToken, '');
    setState(() {});
    if (mounted) {
      context.read<BottomBarBloc>().add(
            const ChangeTabBottomBarEvent(
              bottomBarEnum: BottomBarEnum.home,
              isRefresh: true,
            ),
          );
    }
  }
}
