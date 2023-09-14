import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/custom_textfield.dart';

class MuaHangScrene extends StatefulWidget {
  // int productId;
  const MuaHangScrene({Key? key}) : super(key: key);

  @override
  MuaHangScreneState createState() => MuaHangScreneState();
}

class MuaHangScreneState extends State<MuaHangScrene> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Mua hàng',
        iconLeftTap: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const CustomTextField(
              hintText: 'Họ tên',
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hintText: 'Số điện thoại',
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hintText: 'Địa chỉ',
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hintText: 'Nội dung mua hàng',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () async {
                Navigator.pop(context);
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
