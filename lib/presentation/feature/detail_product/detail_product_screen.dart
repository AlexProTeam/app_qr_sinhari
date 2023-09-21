import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/app/di/injection.dart';
import 'package:qrcode/app/managers/const/status_bloc.dart';
import 'package:qrcode/app/managers/helper.dart';
import 'package:qrcode/domain/login/usecases/app_usecase.dart';
import 'package:qrcode/presentation/feature/detail_product/product_active/ui/detail_product_active.dart';
import 'package:qrcode/presentation/feature/profile/bloc/profile_bloc.dart';

import '../../../app/managers/color_manager.dart';
import '../../../app/managers/const/icon_constant.dart';
import '../../../app/managers/style_manager.dart';
import '../../../app/route/format_utils.dart';
import '../../../app/route/navigation/route_names.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/toast_manager.dart';
import 'bloc/product_detail_bloc.dart';
import 'detail_product_contact.dart';
import 'detail_product_slide.dart';

class ArgumentDetailProductScreen {
  final int? productId;
  final String? url;

  ArgumentDetailProductScreen({this.productId, this.url});
}

class DetailProductScreen extends StatefulWidget {
  final ArgumentDetailProductScreen? argument;

  const DetailProductScreen({Key? key, this.argument}) : super(key: key);

  @override
  DetailProductScreenState createState() => DetailProductScreenState();
}

class DetailProductScreenState extends State<DetailProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: 'Chi tiết',
          isShowBack: true,
          actions: [
            InkWell(
              onTap: () => ToastManager.showToast(context,
                  text: 'Chức năng sẽ sớm ra mắt,'),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  IconConst.heart,
                  width: 22,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => ProductDetailBloc(
              ArgumentDetailProductScreen(
                  productId: widget.argument?.productId,
                  url: widget.argument?.url),
              getIt<AppUseCase>())
            ..add(const InitProductDetailEvent()),
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (BuildContext context, state) {
              if (state.detailProductModel == null ||
                  state.status == BlocStatusEnum.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProductDetailBloc>()
                      .add(const InitProductDetailEvent());
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.detailProductModel != null)
                        DetailProductSlide(
                          images: state.detailProductModel?.data?.photos ?? [],
                        ),
                      const SizedBox(height: 18.5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.detailProductModel?.data?.name ?? '',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  IconConst.star,
                                  width: 13.5,
                                  height: 16,
                                ),
                                const SizedBox(width: 6),
                                RichText(
                                    text: TextSpan(
                                        text: (state.detailProductModel?.data
                                                    ?.rating ??
                                                0)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.black),
                                        children: [
                                      TextSpan(
                                        text:
                                            ' (${(state.detailProductModel?.data?.quantity ?? 0).toString()} sản phẩm)',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: AppColors.colorACACAC),
                                      )
                                    ]))
                              ],
                            ),
                            itemPrice(
                                state.detailProductModel?.data?.unitPrice ?? 0,
                                state.detailProductModel?.data?.price ?? 0),
                            const SizedBox(height: 10)
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (widget.argument?.url != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: state.detailProductModel?.tracking
                                          ?.exceeded ==
                                      true
                                  ? _itemLimit(
                                      getDate(state.detailProductModel?.tracking
                                              ?.datetimeScan ??
                                          ''),
                                      state.detailProductModel?.tracking
                                              ?.exceedingScan ??
                                          '')
                                  : _itemApccept(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Serial: ${state.detailProductModel?.codeActive ?? ''}',
                                    style: TextStyleManager.normalBlue,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 8,
                              width: double.infinity,
                              color: AppColors.grey4,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: _itemRow(
                                    Icons.qr_code_scanner,
                                    state.detailProductModel?.tracking
                                            ?.totalScan ??
                                        0,
                                    'Số lần quét',
                                  )),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: AppColors.grey6,
                                  ),
                                  Expanded(
                                      child: _itemRow(
                                    Icons.person,
                                    state.detailProductModel?.tracking
                                            ?.totalUserScan ??
                                        0,
                                    'Số người quét',
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              height: 8,
                              width: double.infinity,
                              color: AppColors.grey4,
                            ),
                            _itemCompany(
                              name: 'CÔNG TY TNHH SIN HAIR JAPAN',
                              label: 'Nhà phân phối',
                              phone: '0886986222',
                              address:
                                  'T1 331B đường Bát Khối, Phường Long Biên, Quận Long Biên, Thành phố Hà Nội, Việt Nam, Quận Long Biên, Hà Nội',
                              mst: '0109429157',
                            ),
                            Container(
                              height: 8,
                              width: double.infinity,
                              color: AppColors.grey4,
                            ),
                          ],
                        ),
                      if (state.detailProductModel != null) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Mô tả sản phẩm:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Html(
                            data: state.detailProductModel?.data?.description ??
                                "",
                            style: {
                              "html": Style(
                                backgroundColor: Colors.transparent,
                                color: AppColors.grey9,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize(14),
                                padding: HtmlPaddings.zero,
                                fontStyle: FontStyle.normal,
                                wordSpacing: 1.5,
                              ),
                              'img': Style(
                                width: Width(MediaQuery.of(context).size.width),
                                height: Height(
                                  MediaQuery.of(context).size.width * 1.5,
                                ),
                              ),
                              'h1': _getWidthTitleHTML,
                              'h2': _getWidthTitleHTML,
                              'h3': _getWidthTitleHTML,
                              'h4': _getWidthTitleHTML,
                            },
                          ),
                        ),
                      ],
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: CustomButton(
                            width: 343,
                            height: 45,
                            radius: 5,
                            onTap: () {
                              if (widget.argument?.url != null) {
                                context
                                            .read<ProfileBloc>()
                                            .state
                                            .profileModel !=
                                        null
                                    ? Navigator.pushNamed(
                                        context, RouteDefine.activeScrene,
                                        arguments: ArgumentActiveScreen(
                                            productId: state
                                                .detailProductModel?.data?.id))
                                    : Navigator.pushNamed(
                                        context, RouteDefine.loginScreen,
                                        arguments: true);
                              } else {
                                context
                                            .read<ProfileBloc>()
                                            .state
                                            .profileModel !=
                                        null
                                    ? Navigator.pushNamed(
                                        context, RouteDefine.muaHangScrene,
                                        arguments: ArgumentContactScreen(
                                            productId: state
                                                .detailProductModel?.data?.id))
                                    : Navigator.pushNamed(
                                        context, RouteDefine.loginScreen,
                                        arguments: true);
                              }
                            },
                            text: widget.argument?.url != null
                                ? 'Kích hoạt'
                                : 'Mua ngay',
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget itemPrice(int unitPrice, int purchasePrice) {
    if (Helper.getPrice(unitPrice, purchasePrice) == false) {
      return Column(
        children: [
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                FormatUtils.formatCurrencyDoubleToString(unitPrice),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.colorFFC700),
              ),
              const SizedBox(width: 15),
              RichText(
                text: TextSpan(
                  text: FormatUtils.formatCurrencyDoubleToString(purchasePrice),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorACACAC,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.colorACACAC,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            FormatUtils.formatCurrencyDoubleToString(purchasePrice),
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.colorFFC700),
          ),
        ],
      );
    }
  }

  String getDate(String dateTimeScan) {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateFormat dateFormatLast = DateFormat("HH:mm - dd/MM/yyyy");
    DateTime datetime = dateFormat.parse(dateTimeScan);
    final date = dateFormatLast.format(datetime);
    return date;
  }

  Widget _itemCompany({
    required String name,
    required String label,
    required String address,
    String? phone,
    required String mst,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyleManager.mediumBlack
                        .copyWith(color: Colors.blue[700]),
                  ),
                  Text(
                    label,
                    style: TextStyleManager.normalGrey,
                  )
                ],
              )),
              Container(
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.3)),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.arrow_right,
                  color: AppColors.blue,
                  size: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 1,
            color: AppColors.grey4,
          ),
          const SizedBox(height: 12),
          phone != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.arrow_right,
                        color: AppColors.blue,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          phone,
                          style: TextStyleManager.normalBlack,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.arrow_right,
                color: AppColors.blue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: TextStyleManager.normalBlack,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.arrow_right,
                color: AppColors.blue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Mã Số Thuế: $mst',
                  style: TextStyleManager.normalBlack,
                ),
              ),
              const SizedBox(width: 12),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemRow(IconData iconData, int number, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 30,
          color: AppColors.grey7,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: TextStyleManager.mediumBlack.copyWith(
                color: AppColors.blue,
              ),
            ),
            Text(
              label,
              style: TextStyleManager.normalGrey,
            )
          ],
        )
      ],
    );
  }

  Widget _itemLimit(String dateTime, String notify) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: AppColors.red,
      child: Center(
        child: Text(
          'Sản phẩm này đã vượt quá giới hạn quét, được quét vào $dateTime. $notify',
          style: TextStyleManager.normalWhite,
        ),
      ),
    );
  }

  Widget _itemApccept() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: AppColors.green,
      child: const Center(
        child: Text(
          'Sản phẩm chính hãng của CÔNG TY TNHH SIN HAIR JAPAN',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Style get _getWidthTitleHTML => Style(
        width: Width(MediaQuery.of(context).size.width * 0.9),
        fontSize: FontSize(
          20,
        ),
      );
}
