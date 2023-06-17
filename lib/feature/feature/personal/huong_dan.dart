import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/injector_container.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class HuongDanScreen extends StatefulWidget {
  const HuongDanScreen({Key? key}) : super(key: key);

  @override
  HuongDanScreenState createState() => HuongDanScreenState();
}

class HuongDanScreenState extends State<HuongDanScreen> {
  Map _data = {};
  bool isLoadding = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      isLoadding = true;
      final data = await injector<AppClient>().post(
        'policy?type=support_policy',
        handleResponse: false,
      );
      _data = data['policy'];
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e, methodName: '');
    } finally {
      isLoadding = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Chính sách bảo mật',
        iconLeftTap: () {
          Navigator.pop(context);
        },
      ),
      body: isLoadding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        IconConst.policyBackground,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Center(
                            child: Text(
                              'Chính sách bán hàng',
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
                        _data['content'] != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Html(
                                  data: _data['content'],
                                  style: {
                                    "html": Style(
                                      backgroundColor: Colors.white,
                                      color: AppColors.grey9,
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize(14),
                                      padding: HtmlPaddings.zero,
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
