import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../app/utils/screen_utils.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<ScanQrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: _buildQrView(context),
              ),
            ],
          ),
          Positioned(
              left: 0,
              top: GScreenUtil.statusBarHeight,
              child: GestureDetector(
                onTap: () async {
                  // await controller?.pauseCamera();
                  // await controller?.stopCamera();
                  // controller?.dispose();
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      controller.stopCamera();
      // Routes.instance.pop(result: scanData.code ?? '');
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {}
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
