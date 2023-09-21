import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrcode/gen/assets.gen.dart';

import '../../../app/managers/color_manager.dart';

class CheckBillScreen extends StatefulWidget {
  const CheckBillScreen({Key? key}) : super(key: key);

  @override
  State<CheckBillScreen> createState() => _CheckBillScreenState();
}

class _CheckBillScreenState extends State<CheckBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgrScafold,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: _itemBill())],
      ),
    );
  }
}

Widget _itemBill() {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 80,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: const Text(
              'Mã đơn hàng: #3742-652',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  )),
              child: Image.memory(
                base64Decode(
                    ("MTRqanc1ZzZwa2E0Y3dqZGtscXNnOGkwYXdoc2l6ZTA1M3VtOWtocWI0MGxsMWZxMWVwMjl0cGMxeXB4czhoZXJ2bmN5bGR1ZTg5b294eDRoc3JmYzNuNHEzNmdwNml0dHZtNmwzNm5hMndkb3hxMnR3cHFtM2M2Y20yNHdva2E=")
                        .replaceAll("data:image/png;base64,", "")),
                errorBuilder: (c, v, b) => const SizedBox.shrink(),
                width: 35.5,
                height: 35.5,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
      Container(
        color: Colors.white,
        height: 76,
        width: 300,
        child: Row(
          children: [
            Assets.icons.car.image(
              width: 24,
              height: 24,
            ),
            Column(
              children: [
                const Text(
                  'Tình trạng:',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Row(
                  children: [
                    Assets.icons.ellipse69.image(
                      width: 5,
                      height: 5,
                    ),
                    const Text(
                      'Đơn hàng đã hoàn thành',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0085FF)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )
    ],
  );
}
