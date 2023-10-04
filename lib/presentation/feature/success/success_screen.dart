import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Giỏ hàng',
        isShowBack: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              Image.asset(Assets.icons.icSuccess.path),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Đặt hàng thành công',
                textAlign: TextAlign.center,
                style: TextStyleManager.mediumBlack.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              Text(
                'Đơn hàng số #XXXXXX đã được đặt thành công. Bộ phận giao hàng sẽ liên hệ với bạn để có thể  nhanh nhất trả về',
                textAlign: TextAlign.center,
                style: TextStyleManager.mediumBlack.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(context, RouteDefine.detailOrder);
                },
                child: Text(
                  'Chi tiết đơn hàng xem tại đây.',
                  textAlign: TextAlign.center,
                  style: TextStyleManager.mediumBlack.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.color0A6CFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
