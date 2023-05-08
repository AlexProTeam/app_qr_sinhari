import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/common/utils/screen_utils.dart';
import 'package:qrcode/feature/feature/scan/qrcode_scanner_controller.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class ScanQrScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<ScanQrScreen> {
  QRViewController? controller;
  final GlobalKey qrKeyView = GlobalKey(debugLabel: 'QR_view');
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Quét QR',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),

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
              child: CustomGestureDetector(
                onTap: () async {
                  // await controller?.pauseCamera();
                  // await controller?.stopCamera();
                  // controller?.dispose();
                  Routes.instance.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
            onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  QrcodeScannerWithController(key: qrKey,),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.qr_code), onPressed: () {  },),
              Text("Scan QRcode")
            ],
          ),
        ),
       ]),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
