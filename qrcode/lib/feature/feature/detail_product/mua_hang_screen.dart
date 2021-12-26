import 'package:flutter/material.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

import '../../injector_container.dart';

class MuaHangScrene extends StatefulWidget {
  // int productId;
  const MuaHangScrene({Key? key}) : super(key: key);

  @override
  _MuaHangScreneState createState() => _MuaHangScreneState();
}

class _MuaHangScreneState extends State<MuaHangScrene> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Mua hàng',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Họ tên',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Số điện thoại',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Địa chỉ',
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Nội dung mua hàng',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () async {
                Routes.instance.pop();
                // try {
                //   injector<LoadingBloc>().add(StartLoading());
                //   await injector<AppClient>().post(
                //       'save-contact?product_id=${_detailProductModel?.id}');
                //   injector<SnackBarBloc>().add(ShowSnackbarEvent(
                //       type: SnackBarType.success,
                //       content: 'Lưu thông tin thành công'));
                // } catch (e) {
                //   CommonUtil.handleException(injector<SnackBarBloc>(), e,
                //       methodName: 'getThemes CourseCubit');
                // } finally {
                //   injector<LoadingBloc>().add(FinishLoading());
                // }
              },
              text: 'Mua hàng',
            )
          ],
        ),
      ),
    );
  }
}
