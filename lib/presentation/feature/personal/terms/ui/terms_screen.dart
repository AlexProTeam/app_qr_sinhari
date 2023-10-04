import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qrcode/app/managers/status_bloc.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../../../app/managers/color_manager.dart';
import '../../../../../app/managers/style_manager.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../../enum/personal_menu_enum.dart';
import '../bloc/preferences_bloc.dart';

class PolicyScreen extends StatefulWidget {
  final PolicyEnum policy;

  const PolicyScreen({Key? key, required this.policy}) : super(key: key);

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
        title: widget.policy.getNameTerms,
        isShowBack: true,
      ),
      body: BlocProvider(
        create: (context) =>
            PreferencesBloc()..add(InitPreferencesEvent(widget.policy)),
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
            if (state.status == BlocStatusEnum.loading) {
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
                      Assets.icons.policyBackground.image(
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
                              widget.policy.getSubTitleTerms,
                              style: TextStyleManager.mediumBlack.copyWith(
                                color: Colors.white,
                              ),
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
                        state.data?.policy?.content != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4)
                                        .copyWith(bottom: 100),
                                child: Html(
                                  data: state.data?.policy?.content,
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
