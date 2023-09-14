import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../app/managers/color_manager.dart';
import '../../../../../app/managers/const/icon_constant.dart';
import '../../../../../app/managers/style_manager.dart';
import '../../../../../app/route/enum_app_status.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../bloc/preferences_bloc.dart';

class PolicyScreen extends StatefulWidget {
  final String? arg;

  const PolicyScreen({Key? key, this.arg}) : super(key: key);

  @override
  PolicyScreenState createState() => PolicyScreenState();
}

class PolicyScreenState extends State<PolicyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: widget.arg == 'Screen1'
            ? 'Chính sách bán hàng'
            : widget.arg == "Screen2"
                ? 'Chính sách bảo mật'
                : 'Điều khoản sử dụng',
        isShowBack: true,
      ),
      body: BlocProvider(
        create: (context) =>
            PreferencesBloc()..add(InitDataEvent(widget.arg ?? '')),
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
            if (state.status == ScreenStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
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
                              widget.arg == 'Screen1'
                                  ? 'Chính sách bán hàng'
                                  : widget.arg == 'Screen2'
                                      ? 'Chính sách bảo mật'
                                      : 'ĐIỀU KHOẢN BẢO MẬT &\nCHÍNH SACH ỨNG DỤNG',
                              style: TextStyleManager.mediumBlack
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
                        state.data['content'] != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4)
                                        .copyWith(bottom: 100),
                                child: Html(
                                  data: state.data['content'],
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
            );
          },
        ),
      ),
    );
  }
}
