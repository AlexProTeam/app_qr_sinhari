import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:qrcode/common/bloc/loading_bloc/loading_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:qrcode/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/model/detail_product_model.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/network/client.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/format_utils.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_active.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_contact.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_slide.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_button.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

import '../../injector_container.dart';

class ArgumentDetailProductScreen {
  final int? productId;
  final String? url;

  ArgumentDetailProductScreen({this.productId, this.url});
}

class DetailProductScreen extends StatefulWidget {
  final ArgumentDetailProductScreen? argument;

  const DetailProductScreen({Key? key, this.argument}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  DetailProductModel? _detailProductModel;
  TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoadding = false;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      isLoadding = true;
      if (widget.argument?.url != "") {
        await _getProductByUrl();
        return;
      }
      final data = await injector<AppClient>()
          .get('products/show/${widget.argument?.productId}');
      _detailProductModel = DetailProductModel.fromJson(data['data']);
      setState(() {});
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes CourseCubit');
      Routes.instance.pop();
    } finally {
      isLoadding = false;
    }
  }

  Future _getProductByUrl() async {
    try {
      final deviceId = injector<AppCache>().deviceId;
      final data = await injector<AppClient>().get(
          'scan-qr-code?device_id=$deviceId&city=hanoi&region=vn&url=${widget.argument?.url}');
      _detailProductModel = DetailProductModel.fromJson(data['data']['data']);
      _detailProductModel?.serialCode = data['data']['code_active'];
      if (data['data']['tracking'] != null) {
        _detailProductModel?.countScan = data['data']['tracking']['totalScan'];
        _detailProductModel?.countPersonScan =
            data['data']['tracking']['totalUserScan'];
        _detailProductModel?.limitScan = data['data']['tracking']['exceeded'];
        _detailProductModel?.exceedingScan =
            data['data']['tracking']['exceeding_scan'];
        String? dateTimeScan = data['data']['tracking']['datetime_scan'];
        if (dateTimeScan != null) {
          DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
          DateFormat dateFormatLast = DateFormat("HH:mm - dd/MM/yyyy");
          DateTime datetime = dateFormat.parse(dateTimeScan);
          _detailProductModel?.dateTimeScanLimit =
              dateFormatLast.format(datetime);
        }
      }
      setState(() {});
    } catch (e) {
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        content: 'URL không đúng định dạng',
        type: SnackBarType.warning,
      ));
      Routes.instance.pop();
    }
  }

  void _onContact() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      await injector<AppClient>()
          .post('save-contact?product_id=${_detailProductModel?.id}');
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
          type: SnackBarType.success, content: 'Lưu thông tin thành công'));
    } catch (e) {
      CommonUtil.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes CourseCubit');
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
      body: isLoadding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _detailProductModel != null
                            ? DetailProductSlide(
                                images: _detailProductModel?.photos,
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_detailProductModel?.name ?? ''}',
                                style: AppTextTheme.normalBlack,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${FormatUtils.formatCurrencyDoubleToString(_detailProductModel?.unitPrice)}',
                                style: AppTextTheme.mediumPrimary,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    IconConst.fakeStar,
                                    width: 80,
                                    height: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: [
                            widget.argument?.url != null
                                ? Container(
                                    child:
                                        _detailProductModel?.limitScan == true
                                            ? _itemLimit(
                                                _detailProductModel
                                                        ?.dateTimeScanLimit ??
                                                    '',
                                                _detailProductModel
                                                        ?.exceedingScan ??
                                                    '')
                                            : _itemApccept(),
                                  )
                                : Container(),
                            Container(
                              height: 8,
                              width: double.infinity,
                              color: AppColors.grey4,
                            ),
                            widget.argument?.url != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Serial: ${_detailProductModel?.serialCode ?? ''}',
                                              style: AppTextTheme.normalBlue,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: _itemRow(
                                              Icons.qr_code_scanner,
                                              _detailProductModel?.countScan ??
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
                                              _detailProductModel
                                                      ?.countPersonScan ??
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
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        _detailProductModel != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Html(
                                  data: _detailProductModel?.description ?? "",
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
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: CustomButton(
                    onTap: () {
                      if (widget.argument?.url != null) {
                        injector<AppCache>().profileModel != null
                            ? Routes.instance.navigateTo(RouteName.ActiveScrene,
                                arguments: ArgumentActiveScreen(
                                    productId: _detailProductModel?.id))
                            : Routes.instance.navigateTo(RouteName.LoginScreen,
                                arguments: true);
                      } else {
                        injector<AppCache>().profileModel != null
                            ? Routes.instance.navigateTo(
                                RouteName.MuaHangScrene,
                                arguments: ArgumentContactScreen(
                                    productId: _detailProductModel?.id))
                            : Routes.instance.navigateTo(RouteName.LoginScreen,
                                arguments: true);
                      }
                    },
                    text:
                        widget.argument?.url != null ? 'Kích hoạt' : 'Mua hàng',
                  ),
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
              ],
            ),
    );
  }

  Widget _itemCompany(
      {required String name,
      required String label,
      required String address,
      String? phone,
      required String mst}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text(
                    name,
                    style: AppTextTheme.mediumBlack
                        .copyWith(color: Colors.blue[700]),
                  ),
                  Text(
                    label,
                    style: AppTextTheme.normalGrey,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )),
              Container(
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.3)),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_right,
                  color: Colors.blue,
                  size: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Divider(
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
                      Icon(
                        Icons.arrow_right,
                        color: Colors.blue,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          phone,
                          style: AppTextTheme.normalBlack,
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
              Icon(
                Icons.arrow_right,
                color: Colors.blue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: AppTextTheme.normalBlack,
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
              Icon(
                Icons.arrow_right,
                color: Colors.blue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Mã Số Thuế: $mst',
                  style: AppTextTheme.normalBlack,
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
              '${number}',
              style: AppTextTheme.mediumBlack.copyWith(
                color: AppColors.blue,
              ),
            ),
            Text(
              label,
              style: AppTextTheme.normalGrey,
            )
          ],
        )
      ],
    );
  }

  Widget _itemLimit(String dateTime, String notify) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: Colors.red,
      child: Center(
        child: Text(
          'Sản phẩm này đã vượt quá giới hạn quét, được quét vào $dateTime. $notify',
          style: AppTextTheme.normalWhite,
        ),
      ),
    );
  }

  Widget _itemApccept() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: Colors.green,
      child: Center(
        child: Text(
          'Sản phẩm chính hãng của CÔNG TY TNHH SIN HAIR JAPAN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
