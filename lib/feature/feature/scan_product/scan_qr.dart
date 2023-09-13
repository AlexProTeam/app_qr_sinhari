import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/scan/scanner_error_widget.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';
import 'package:scan/scan.dart';

import '../../routes.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../../widgets/qr_scanner_overlay.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
import 'bloc/scan_qr_bloc.dart';
import 'enum/scan_enum.dart';

class ScanQrNested extends StatelessWidget {
  const ScanQrNested({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedRouteWrapper(
      onGenerateRoute: Routes.generateBottomBarRoute,
      navigationKey: Routes.scanKey,
      initialRoute: BottomBarEnum.scan.getRouteNames,
    );
  }
}

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  ScanQrScreenState createState() => ScanQrScreenState();
}

class ScanQrScreenState extends State<ScanQrScreen>
    with SingleTickerProviderStateMixin {
  //int _currentIndex = ScanTypeEnum.product.index;
  final ImagePicker _picker = ImagePicker();

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
    autoStart: true,
  );

  @override
  void initState() {
    controller.stop();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgrScafold,
      appBar: BaseAppBar(
        title: 'Quét mã QR',
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ScanBloc(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 17),
              _buildQrView(),
              const SizedBox(height: 20),
              const Text(
                'Kiểm tra sản phẩm chính hãng',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<ScanBloc, int>(
                builder: (context, currentIndex) {
                  return Row(
                    children: List.generate(
                      ScanTypeEnum.values.length,
                      (index) => _buildBottomScanQrItem(
                        index == currentIndex,
                        onTap: () {
                          switch (ScanTypeEnum.values[index]) {
                            case ScanTypeEnum.image:
                              return _pickImage();
                            case ScanTypeEnum.product:
                              break;
                            case ScanTypeEnum.invoice:
                              return ToastManager.showToast(
                                context,
                                delaySecond: 1,
                                text: 'chức năng sẽ sớm ra mắt',
                                afterShowToast: () => _resetItemToScanCamera(),
                              );
                          }
                          // Dispatch the event to update currentIndex
                          context
                              .read<ScanBloc>()
                              .add(UpdateCurrentIndex(index));
                        },
                        enumData: ScanTypeEnum.values[index],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: SizedBox(
              width: 343,
              height: 492,
              child: MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) =>
                    ScannerErrorWidget(error: error),
                fit: BoxFit.cover,
                onDetect: (barcode) async {
                  controller.stop();
                  await _scanDetailQr(barcode.barcodes.first.rawValue ?? '');
                },
              ),
            ),
          ),
        ),
        QRScannerOverlay(
          overlayColour: Colors.black.withOpacity(0.5),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 51, vertical: 18),
          child: CustomTextField(
            height: 26,
            border: 12,
            fontsize: 12,
            hintText: 'Kiểm tra bằng mã code',
            icon: Icons.search,
          ),
        ),
        Positioned(
          top: 420,
          child: InkWell(
            onTap: () => controller.toggleTorch(),
            child: ValueListenableBuilder(
              valueListenable: controller.hasTorchState,
              builder: (context, state, child) {
                if (state != true) {
                  return const SizedBox.shrink();
                }
                return Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.torchState,
                      builder: (context, state, child) {
                        if (state == null) {
                          return Image.asset(
                            IconConst.flash,
                            width: 24,
                            height: 24,
                          );
                        }
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(
                              Icons.flash_off_rounded,
                              size: 24,
                              color: Colors.white,
                            );
                          case TorchState.on:
                            return Image.asset(
                              IconConst.flash,
                              width: 24,
                              height: 24,
                            );
                        }
                      },
                    ),
                    const Text(
                      'Bật đèn Flash',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomScanQrItem(
    bool isSelect, {
    required ScanTypeEnum enumData,
    required Function() onTap,
  }) {
    final color = isSelect ? Colors.black : AppColors.colorACACAC;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isSelect ? enumData.getIconSelect : enumData.getIconUnSelect,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 2),
              Text(
                enumData.getTitle,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanDetailQr(String url) async {
    if (url.contains('http://qcheck.vn/')) {
      CommonUtil.runUrl(url);
    } else {
      Navigator.pushNamed(
        context,
        RouteName.detailProductScreen,
        arguments: ArgumentDetailProductScreen(url: url),
      ).then((value) => _resetItemToScanCamera());
    }
  }

  Future<void> _pickImage() async {
    final res = await _picker.pickImage(source: ImageSource.gallery);

    String? str = await Scan.parse(res?.path ?? '');
    if (str != null) {
      return await _scanDetailQr(str);
    }
    if (mounted) {
      return ToastManager.showToast(
        context,
        text: 'không nhận dạng được qr code',
        afterShowToast: () => _resetItemToScanCamera(),
      );
    }
  }

  void _resetItemToScanCamera() {
    // setState(() {
    //   _currentIndex = ScanTypeEnum.product.index;
    // });
    context
        .read<ScanBloc>()
        .add(UpdateCurrentIndex(ScanTypeEnum.product.index));
    controller.start();
  }
}
