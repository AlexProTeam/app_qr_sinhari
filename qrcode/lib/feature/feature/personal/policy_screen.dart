import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  Map _data = {};

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().post('policy',
          handleResponse: false, body: {'type': 'privacy_policy'});
      _data = data['policy'];
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Điều khoản chính sách',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  IconConst.policy_background,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: Text(
                        'ĐIỀU KHOẢN BẢO MẬT &\nCHÍNH SACH ỨNG DỤNG',
                        style: AppTextTheme.mediumBlack
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    '${_data['name'] ?? ''}',
                    style: AppTextTheme.mediumBlack,
                  ),
                  const SizedBox(height: 12),
                  _data['content'] != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Html(
                            data: _data['content'],
                            style: {
                              "html": Style(
                                backgroundColor: Colors.white,
                                color: AppColors.grey9,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize(14),
                                padding: EdgeInsets.all(0),
                                fontStyle: FontStyle.normal,
                                wordSpacing: 1.5,
                              ),
                            },
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
