import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_slide.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../injector_container.dart';

class DetailProductScreen extends StatefulWidget {
  final int? productId;

  const DetailProductScreen({Key? key, this.productId}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  DetailProductModel? _detailProductModel;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data =
          await injector<AppClient>().get('products/show/${widget.productId}');
      _detailProductModel = DetailProductModel.fromJson(data['data']);
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes CourseCubit');
      Routes.instance.pop();
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Chi tiết sản phẩm',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailProductModel!=null?  DetailProductSlide(
              // images: _detailProductModel?.photos,
            ):const SizedBox(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_detailProductModel?.name}',
                    style: AppTextTheme.normalBlack,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(
                        IconConst.fakeStar,
                        width: 80,
                        height: 15,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${FormatUtils.formatCurrencyDoubleToString(_detailProductModel?.purchasePrice ?? _detailProductModel?.unitPrice)}',
                    style: AppTextTheme.mediumBlack.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),

                ],
              ),
            ),
            _detailProductModel != null
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Html(
              data: _detailProductModel?.description,
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
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
