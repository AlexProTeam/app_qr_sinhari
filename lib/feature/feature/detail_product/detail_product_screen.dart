import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';

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

  // void _onInitData() async {
  //   try {
  //     _isLoading = true;
  //     if ((widget.argument?.url ?? '').isNotEmpty) {
  //       await _getProductByUrl();
  //       return;
  //     }
  //     await injector<AppClient>()
  //         .get('products/show/${widget.argument?.productId}');
  //     // _detailProductModel = DetailProductModel.fromJson(data['data']);
  //     if (mounted) {
  //       await ToastManager.showToast(context, text: 'Kích hoạt thành công');
  //       // _isLoading = false;
  //     }
  //
  //     if (!mounted) return;
  //     Navigator.pop(context);
  //     // _isLoading = false;
  //   } catch (e) {
  //     CommonUtil.handleException(e, methodName: 'getThemes CourseCubit');
  //     Navigator.pop(context);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }
  // void _initData() async {
  //   DetailProductModel? detailProductModel = context.read<DetailProductModel>().state.profileModel;
  //   _detailProductModel?.photos = profileModel?.i ?? '';
  //   _phoneController.text = profileModel?.phone ?? '';
  //   _adddressController.text = profileModel?.address ?? '';
  //   _contentController.text = "Tôi muốn kích hoạt sản phẩm này";
  // }
  //
  // void _initData() async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     if ((widget.argument?.url ?? '').isNotEmpty) {
  //       await _getProductByUrl();
  //       return;
  //     }
  //     final data = await injector<AppClient>()
  //         .get('products/show/${widget.argument?.productId}');
  //     _detailProductModel = DetailProductModel.fromJson(data['data']);
  //     setState(() {});
  //   } catch (e) {
  //     CommonUtil.handleException(e, methodName: 'getThemes CourseCubit');
  //     Navigator.pop(context);
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // Future _getProductByUrl() async {
  //   try {
  //     _isLoading = true;
  //     final deviceId = injector<AppCache>().deviceId;
  //     final data = await injector<AppClient>().get(
  //         'scan-qr-code?device_id=$deviceId&city=hanoi&region=vn&url=${widget.argument?.url ?? ''}');
  //     _detailProductModel = DetailProductModel.fromJson(data['data']['data']);
  //     _detailProductModel?.serialCode = data['data']['code_active'];
  //     if (data['data']['tracking'] != null) {
  //       _detailProductModel?.countScan = data['data']['tracking']['totalScan'];
  //       _detailProductModel?.countPersonScan =
  //           data['data']['tracking']['totalUserScan'];
  //       _detailProductModel?.limitScan = data['data']['tracking']['exceeded'];
  //       _detailProductModel?.exceedingScan =
  //           data['data']['tracking']['exceeding_scan'];
  //       String? dateTimeScan = data['data']['tracking']['datetime_scan'];
  //       if (dateTimeScan != null) {
  //         DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
  //         DateFormat dateFormatLast = DateFormat("HH:mm - dd/MM/yyyy");
  //         DateTime datetime = dateFormat.parse(dateTimeScan);
  //         _detailProductModel?.dateTimeScanLimit =
  //             dateFormatLast.format(datetime);
  //       }
  //     }
  //   } catch (e) {
  //     CommonUtil.handleException(e, methodName: '');
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

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
      // body: BlocProvider(
      //   create: (context) =>
      //       ProductDetailBloc()..add(const InitProductDetailEvent()),
      //   child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
      //     builder: (BuildContext context, state) {
      //       if (state.detailProductModel == null ||
      //           state.status == ScreenStatus.loading) {
      //         return const Center(child: CircularProgressIndicator());
      //       } else {
      //         return RefreshIndicator(
      //           onRefresh: () async {
      //             context
      //                 .read<ProductDetailBloc>()
      //                 .add(const InitProductDetailEvent());
      //           },
      //           child: SingleChildScrollView(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 if (state.detailProductModel != null)
      //                   DetailProductSlide(
      //                     images: state.detailProductModel?.photos,
      //                   ),
      //                 const SizedBox(height: 18.5),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 16),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         state.detailProductModel?.name ?? '',
      //                         style: const TextStyle(
      //                             fontSize: 18,
      //                             fontWeight: FontWeight.w600,
      //                             color: AppColors.black),
      //                       ),
      //                       const SizedBox(height: 8),
      //                       Row(
      //                         crossAxisAlignment: CrossAxisAlignment.end,
      //                         children: [
      //                           Image.asset(
      //                             IconConst.star,
      //                             width: 13.5,
      //                             height: 16,
      //                           ),
      //                           const SizedBox(width: 6),
      //                           RichText(
      //                               text: TextSpan(
      //                                   text: (state.detailProductModel
      //                                               ?.rating ??
      //                                           0)
      //                                       .toString(),
      //                                   style: const TextStyle(
      //                                       fontSize: 12,
      //                                       fontWeight: FontWeight.w300,
      //                                       color: AppColors.black),
      //                                   children: [
      //                                 TextSpan(
      //                                   text:
      //                                       ' (${(state.detailProductModel?.quantity ?? 0).toString()} sản phẩm)',
      //                                   style: const TextStyle(
      //                                       fontSize: 12,
      //                                       fontWeight: FontWeight.w300,
      //                                       color: AppColors.colorACACAC),
      //                                 )
      //                               ]))
      //                         ],
      //                       ),
      //                       const SizedBox(height: 16),
      //                       Row(
      //                         crossAxisAlignment: CrossAxisAlignment.end,
      //                         children: [
      //                           Text(
      //                             FormatUtils.formatCurrencyDoubleToString(
      //                                 state.detailProductModel?.unitPrice),
      //                             style: const TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 14,
      //                                 color: AppColors.colorFFC700),
      //                           ),
      //                           const SizedBox(width: 15),
      //                           RichText(
      //                             text: TextSpan(
      //                               text: FormatUtils
      //                                   .formatCurrencyDoubleToString(state
      //                                       .detailProductModel
      //                                       ?.purchasePrice),
      //                               style: const TextStyle(
      //                                 fontSize: 10,
      //                                 fontWeight: FontWeight.w500,
      //                                 color: AppColors.colorACACAC,
      //                                 decoration: TextDecoration.lineThrough,
      //                                 decorationColor: AppColors.colorACACAC,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       const SizedBox(height: 10)
      //                     ],
      //                   ),
      //                 ),
      //                 const SizedBox(height: 12),
      //                 if (widget.argument?.url != null)
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Container(
      //                         child:
      //                             state.detailProductModel?.limitScan == true
      //                                 ? _itemLimit(
      //                                     state.detailProductModel
      //                                             ?.dateTimeScanLimit ??
      //                                         '',
      //                                     state.detailProductModel
      //                                             ?.exceedingScan ??
      //                                         '')
      //                                 : _itemApccept(),
      //                       ),
      //                       Padding(
      //                         padding:
      //                             const EdgeInsets.symmetric(vertical: 12),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Text(
      //                               'Serial: ${state.detailProductModel?.serialCode ?? ''}',
      //                               style: AppTextTheme.normalBlue,
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       Container(
      //                         height: 8,
      //                         width: double.infinity,
      //                         color: AppColors.grey4,
      //                       ),
      //                       Padding(
      //                         padding:
      //                             const EdgeInsets.symmetric(vertical: 12),
      //                         child: Row(
      //                           children: [
      //                             Expanded(
      //                                 child: _itemRow(
      //                               Icons.qr_code_scanner,
      //                               state.detailProductModel?.countScan ?? 0,
      //                               'Số lần quét',
      //                             )),
      //                             Container(
      //                               width: 1,
      //                               height: 50,
      //                               color: AppColors.grey6,
      //                             ),
      //                             Expanded(
      //                                 child: _itemRow(
      //                               Icons.person,
      //                               state.detailProductModel
      //                                       ?.countPersonScan ??
      //                                   0,
      //                               'Số người quét',
      //                             )),
      //                           ],
      //                         ),
      //                       ),
      //                       Container(
      //                         height: 8,
      //                         width: double.infinity,
      //                         color: AppColors.grey4,
      //                       ),
      //                       _itemCompany(
      //                         name: 'CÔNG TY TNHH SIN HAIR JAPAN',
      //                         label: 'Nhà phân phối',
      //                         phone: '0886986222',
      //                         address:
      //                             'T1 331B đường Bát Khối, Phường Long Biên, Quận Long Biên, Thành phố Hà Nội, Việt Nam, Quận Long Biên, Hà Nội',
      //                         mst: '0109429157',
      //                       ),
      //                       Container(
      //                         height: 8,
      //                         width: double.infinity,
      //                         color: AppColors.grey4,
      //                       ),
      //                     ],
      //                   ),
      //                 if (state.detailProductModel != null) ...[
      //                   const Padding(
      //                     padding: EdgeInsets.symmetric(horizontal: 16),
      //                     child: Text(
      //                       'Mô tả sản phẩm:',
      //                       style: TextStyle(
      //                           fontSize: 18,
      //                           fontWeight: FontWeight.w600,
      //                           color: AppColors.black),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 8),
      //                     child: Html(
      //                       data: state.detailProductModel?.description ?? "",
      //                       style: {
      //                         "html": Style(
      //                           backgroundColor: Colors.transparent,
      //                           color: AppColors.grey9,
      //                           fontWeight: FontWeight.w500,
      //                           fontSize: FontSize(14),
      //                           padding: HtmlPaddings.zero,
      //                           fontStyle: FontStyle.normal,
      //                           wordSpacing: 1.5,
      //                         ),
      //                         'img': Style(
      //                           width:
      //                               Width(MediaQuery.of(context).size.width),
      //                           height: Height(
      //                             MediaQuery.of(context).size.width * 1.5,
      //                           ),
      //                         ),
      //                         'h1': _getWidthTitleHTML,
      //                         'h2': _getWidthTitleHTML,
      //                         'h3': _getWidthTitleHTML,
      //                         'h4': _getWidthTitleHTML,
      //                       },
      //                     ),
      //                   ),
      //                   'h1': _getWidthTitleHTML,
      //                   'h2': _getWidthTitleHTML,
      //                   'h3': _getWidthTitleHTML,
      //                   'h4': _getWidthTitleHTML,
      //                 },
      //               ),
      //             ),
      //           ],
      //           Center(
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 18),
      //               child: CustomButton(
      //                 width: 343,
      //                 height: 45,
      //                 radius: 5,
      //                 onTap: () {
      //                   if (widget.argument?.url == null) {
      //                     context.read<ProfileBloc>().state.profileModel !=
      //                             null
      //                         ? Navigator.pushNamed(
      //                             context, RouteName.activeScrene,
      //                             arguments: ArgumentActiveScreen(
      //                                 productId: _detailProductModel?.id))
      //                         : Navigator.pushNamed(
      //                             context, RouteName.loginScreen,
      //                             arguments: true);
      //                   } else {
      //                     context.read<ProfileBloc>().state.profileModel !=
      //                             null
      //                         ? Navigator.pushNamed(
      //                             context, RouteName.muaHangScrene,
      //                             arguments: ArgumentContactScreen(
      //                                 productId: _detailProductModel?.id))
      //                         : Navigator.pushNamed(
      //                             context, RouteName.loginScreen,
      //                             arguments: true);
      //                   }
      //                 },
      //                 text: widget.argument?.url != null
      //                     ? 'Kích hoạt'
      //                     : 'Mua ngay',
      //               ),
      //             ),
      //           ),
      //         );
      //       }
      //     },
      //   ),
      // )
    );
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
                    style: AppTextTheme.mediumBlack
                        .copyWith(color: Colors.blue[700]),
                  ),
                  Text(
                    label,
                    style: AppTextTheme.normalGrey,
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
              const Icon(
                Icons.arrow_right,
                color: AppColors.blue,
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
              const Icon(
                Icons.arrow_right,
                color: AppColors.blue,
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
              '$number',
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: AppColors.red,
      child: Center(
        child: Text(
          'Sản phẩm này đã vượt quá giới hạn quét, được quét vào $dateTime. $notify',
          style: AppTextTheme.normalWhite,
        ),
      ),
    );
  }

// Widget _itemApccept() {
//   return Container(
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//     color: AppColors.green,
//     child: const Center(
//       child: Text(
//         'Sản phẩm chính hãng của CÔNG TY TNHH SIN HAIR JAPAN',
//         style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//       ),
//     ),
//   );
// }
//
// Style get _getWidthTitleHTML => Style(
//       width: Width(MediaQuery.of(context).size.width * 0.9),
//       fontSize: FontSize(
//         20,
//       ),
//     );
// }
}