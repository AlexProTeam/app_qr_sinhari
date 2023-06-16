import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/scan/scanner_error_widget.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/custom_textfield.dart';

import '../widgets/qr_scanner_overlay.dart';

enum IconHomeEnum {
  Image,
  Product,
  Invoice,
}

extension IconHomeEx on IconHomeEnum {
  String get getIcon {
    switch (this) {
      case IconHomeEnum.Image:
        return IconConst.ScanImage;
      case IconHomeEnum.Product:
        return IconConst.ScanProduct;
      case IconHomeEnum.Invoice:
        return IconConst.ScanInvoice;
    }
  }

  String get getTitle {
    switch (this) {
      case IconHomeEnum.Image:
        return 'Quét hình';
      case IconHomeEnum.Product:
        return 'Quét sản phẩm';
      case IconHomeEnum.Invoice:
        return 'Quét đơn';
    }
    return '';
  }
}

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<ScanQrScreen>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;
  bool isStarted = true;
  Future<void> _scanDetailQr(String url) async {
    LOG.w('_onScan: $url');
    if (url.isNotEmpty) {
      LOG.w('_onScan: requestNe');
      if (url.contains('http://qcheck.vn/')) {
        CommonUtil.runUrl(url);
      } else {
        await Routes.instance.navigateTo(RouteName.DetailProductScreen,
            arguments: ArgumentDetailProductScreen(
              url: url,
            ));
        print('$url');
      }
      //
    }
  }

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.normal
    // detectionTimeoutMs: 1000,
    // returnImage: false,
  );
  final GlobalKey qrKeyView = GlobalKey(debugLabel: 'QR_view');
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // customAppBar: CustomAppBar(
      //   title: 'Quét QR',
      //   iconLeftTap: () {
      //     Routes.instance.pop();
      //   },
      // ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 18,
                    color: Color(0xFFACACAC),
                  )),
              Text(
                'Quét mã QR',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(width: 40),
            ],
          ),
          SizedBox(height: 17),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildQrView(context),
                  SizedBox(height: 20),
                  Text(
                    'Kiểm tra sản phẩm chính hãng',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: List.generate(
                        IconHomeEnum.values.length,
                        (index) => _buildBottomScanQrItem(index),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Đặt bán kính bo góc
            child: Container(
              width: 343,
              height: 492,
              child: MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                fit: BoxFit.cover,
                onDetect: (barcode) async {
                  setState(() {
                    this.barcode = barcode;
                  });
                  await _scanDetailQr(
                      this.barcode?.barcodes.first.rawValue ?? '');
                  debugPrint('qrcode ${this.barcode?.barcodes.first.rawValue}');
                },
              ),
            ),
          ),
        ),
        QRScannerOverlay(
          overlayColour: Colors.black.withOpacity(0.5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 51, vertical: 18),
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
                            IconConst.Flash,
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
                              IconConst.Flash,
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
                  Text(
                    'Bật đèn Flash',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white),
                  )
                ],
              );
            },
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(
        //     alignment: Alignment.bottomCenter,
        //     height: 100,
        //     color: Colors.black.withOpacity(0.4),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         ValueListenableBuilder(
        //           valueListenable: controller.hasTorchState,
        //           builder: (context, state, child) {
        //             if (state != true) {
        //               return const SizedBox.shrink();
        //             }
        //             return IconButton(
        //               color: Colors.white,
        //               icon: ValueListenableBuilder(
        //                 valueListenable: controller.torchState,
        //                 builder: (context, state, child) {
        //                   if (state == null) {
        //                     return const Icon(
        //                       Icons.flash_off,
        //                       color: Colors.grey,
        //                     );
        //                   }
        //                   switch (state as TorchState) {
        //                     case TorchState.off:
        //                       return const Icon(
        //                         Icons.flash_off,
        //                         color: Colors.grey,
        //                       );
        //                     case TorchState.on:
        //                       return const Icon(
        //                         Icons.flash_on,
        //                         color: Colors.yellow,
        //                       );
        //                   }
        //                 },
        //               ),
        //               iconSize: 32.0,
        //               onPressed: () => controller.toggleTorch(),
        //             );
        //           },
        //         ),
        //         IconButton(
        //           color: Colors.white,
        //           icon: isStarted
        //               ? const Icon(Icons.stop)
        //               : const Icon(Icons.play_arrow),
        //           iconSize: 32.0,
        //           onPressed: _startOrStop,
        //         ),
        //         Center(
        //           child: SizedBox(
        //             width: MediaQuery.of(context).size.width - 200,
        //             height: 50,
        //             child: FittedBox(
        //               child: Text(
        //                 barcode?.barcodes.first.rawValue ?? 'Scan something!',
        //                 overflow: TextOverflow.fade,
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .headlineMedium!
        //                     .copyWith(color: Colors.white),
        //               ),
        //             ),
        //           ),
        //         ),
        //         IconButton(
        //           color: Colors.white,
        //           icon: ValueListenableBuilder(
        //             valueListenable: controller.cameraFacingState,
        //             builder: (context, state, child) {
        //               if (state == null) {
        //                 return const Icon(Icons.camera_front);
        //               }
        //               switch (state as CameraFacing) {
        //                 case CameraFacing.front:
        //                   return const Icon(Icons.camera_front);
        //                 case CameraFacing.back:
        //                   return const Icon(Icons.camera_rear);
        //               }
        //             },
        //           ),
        //           iconSize: 32.0,
        //           onPressed: () => controller.switchCamera(),
        //         ),
        //         IconButton(
        //           color: Colors.white,
        //           icon: const Icon(Icons.image),
        //           iconSize: 32.0,
        //           onPressed: () async {
        //             final ImagePicker picker = ImagePicker();
        //             // Pick an image
        //             final XFile? image = await picker.pickImage(
        //               source: ImageSource.gallery,
        //             );
        //             if (image != null) {
        //               if (await controller.analyzeImage(image.path)) {
        //                 if (!mounted) return;
        //                 await _scanDetailQr(
        //                     this.barcode?.barcodes.first.rawValue ?? '');
        //                 debugPrint(
        //                     'qrcode images ${this.barcode?.barcodes.first.rawValue}');
        //                 ScaffoldMessenger.of(context).showSnackBar(
        //                   const SnackBar(
        //                     content: Text('Barcode found!'),
        //                     backgroundColor: Colors.green,
        //                   ),
        //                 );
        //               } else {
        //                 if (!mounted) return;
        //                 ScaffoldMessenger.of(context).showSnackBar(
        //                   const SnackBar(
        //                     content: Text('No barcode found!'),
        //                     backgroundColor: Colors.red,
        //                   ),
        //                 );
        //               }
        //             }
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

Widget _buildBottomScanQrItem(int index) {
  return Expanded(
    child: GestureDetector(
      // onTap: () => changeToTabIndex(index),
      child: Container(
        height: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconHomeEnum.values[index].getIcon,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 2),
            Text(
              IconHomeEnum.values[index].getTitle,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFACACAC)),
            )
          ],
        ),
      ),
    ),
  );
}
