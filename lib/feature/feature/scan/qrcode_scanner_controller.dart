import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/common/utils/common_util.dart';
import 'package:qrcode/common/utils/log_util.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_screen.dart';
import 'package:qrcode/feature/feature/scan/scanner_error_widget.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class QrcodeScannerWithController extends StatefulWidget {
  const QrcodeScannerWithController({Key? key}) : super(key: key);

  @override
  QrcodeScannerWithControllerState createState() =>
      QrcodeScannerWithControllerState();
}

class QrcodeScannerWithControllerState
    extends State<QrcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
    formats: [BarcodeFormat.qrCode],
    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.normal
    // detectionTimeoutMs: 1000,
    // returnImage: false,
  );

  bool isStarted = true;

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

  Future<void> _scanDetailQr(String url) async {
    lOG.w('_onScan: $url');

    lOG.w('_onScan: requestNe');
    if (url.contains('http://qcheck.vn/') || url.contains('http://qrco.de')) {
      CommonUtil.runUrl(url);
    } else {
      Routes.instance.navigateTo(RouteName.detailProductScreen,
          arguments: ArgumentDetailProductScreen(
            url: url,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Quét QR',
        iconLeftTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.cover,
            onDetect: (barcode) async {
              setState(() {
                this.barcode = barcode;
              });
              await _scanDetailQr(this.barcode?.barcodes.first.rawValue ?? '');
              debugPrint('qrcode ${this.barcode?.barcodes.first.rawValue}');
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ValueListenableBuilder(
                    valueListenable: controller.hasTorchState,
                    builder: (context, state, child) {
                      if (state != true) {
                        return const SizedBox.shrink();
                      }
                      return IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.torchState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(
                                Icons.flash_off,
                                color: Colors.grey,
                              );
                            }
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  Icons.flash_on,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      );
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: isStarted
                        ? const Icon(Icons.stop)
                        : const Icon(Icons.play_arrow),
                    iconSize: 32.0,
                    onPressed: _startOrStop,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      child: FittedBox(
                        child: Text(
                          barcode?.barcodes.first.rawValue ?? 'Scan something!',
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.cameraFacingState,
                      builder: (context, state, child) {
                        if (state == null) {
                          return const Icon(Icons.camera_front);
                        }
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front);
                          case CameraFacing.back:
                            return const Icon(Icons.camera_rear);
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => controller.switchCamera(),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.image),
                    iconSize: 32.0,
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        if (await controller.analyzeImage(image.path)) {
                          if (!mounted) return;
                          await _scanDetailQr(
                              barcode?.barcodes.first.rawValue ?? '');
                          debugPrint(
                              'qrcode images ${barcode?.barcodes.first.rawValue}');
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Barcode found!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No barcode found!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
