import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/scan/scanner_error_widget.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';
import 'package:qrcode/feature/widgets/toast_manager.dart';
import 'package:scan/scan.dart';

import '../../routes.dart';
import '../../widgets/nested_route_wrapper.dart';
import '../../widgets/qr_scanner_overlay.dart';
import '../bottom_bar_screen/enum/bottom_bar_enum.dart';
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
  int _currentIndex = ScanTypeEnum.product.index;
  final ImagePicker _picker = ImagePicker();

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Quét mã QR',
          haveIconLeft: false,
        ),
        Expanded(
          child: SingleChildScrollView(
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
                Row(
                  children: List.generate(
                    ScanTypeEnum.values.length,
                    (index) => _buildBottomScanQrItem(
                      index == _currentIndex,
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
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
                      },
                      enumData: ScanTypeEnum.values[index],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQrView() {
    return Stack(
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
          left: 110,
          child: ValueListenableBuilder(
            valueListenable: controller.hasTorchState,
            builder: (context, state, child) {
              if (state != true) {
                return const SizedBox.shrink();
              }
              return Row(
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.torchState,
                      builder: (context, state, child) {
                        if (state == null) {
                          return Image.asset(
                            IconConst.flash,
                            color: Colors.white,
                            width: 24,
                            height: 24,
                          );
                        }
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(
                              Icons.flash_off_rounded,
                              color: Colors.white,
                              size: 24,
                            );
                          case TorchState.on:
                            return Image.asset(
                              IconConst.flash,
                              color: Colors.white,
                              width: 24,
                              height: 24,
                            );
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => controller.toggleTorch(),
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
      ],
    );
  }

  Widget _buildBottomScanQrItem(
    bool isSelect, {
    required ScanTypeEnum enumData,
    required Function() onTap,
  }) {
    final color = isSelect ? Colors.black : const Color(0xFFACACAC);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                enumData.getIcon,
                width: 50,
                height: 50,
                color: color,
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
      await Navigator.pushNamed(
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
    setState(() {
      _currentIndex = ScanTypeEnum.product.index;
    });
  }
}
