import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/managers/style_manager.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/widgets/custom_scaffold.dart';
import 'package:qrcode/presentation/widgets/input_custom.dart';
import 'package:qrcode/presentation/widgets/toast_manager.dart';

class PayDebtQrScreen extends StatefulWidget {
  const PayDebtQrScreen({Key? key}) : super(key: key);

  @override
  State<PayDebtQrScreen> createState() => _PayDebtQrScreenState();
}

class _PayDebtQrScreenState extends State<PayDebtQrScreen> {
  TextEditingController nameBank = TextEditingController();
  TextEditingController numberBank = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    nameBank.text = 'Techcombank';
    numberBank.text = '19323693663221';
    content.text = 'XVCGGAGG';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Thanh toán Công nợ',
        isShowBack: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                Assets.images.welcome.path,
                fit: BoxFit.cover,
                width: 164,
                height: 175,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ghi chú : Chào bạn XXXXX ,'
                ' Đây là nội dung từ api trả về để'
                ' giới thiệu cách thanh toán của hệ thống'
                '.Bạn có thể chuyển khoản qua QR hoặc nội dung ngân hàng ở dưới',
                style: TextStyleManager.mediumBlack14px.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppColors.color000AFF),
              ),
              const SizedBox(
                height: 30,
              ),
              rootView(
                  textEditingController: nameBank,
                  title: 'Ngân hàng',
                  hint: '',
                  ontap: () async {
                    await onTap(
                        nameBank.text, context, 'Copy ngân hàng thành công');
                  }),
              rootView(
                  textEditingController: numberBank,
                  title: 'Số tài khoản',
                  hint: '',
                  ontap: () async {
                    await onTap(
                        numberBank.text, context, 'Copy stk thành công');
                  }),
              rootView(
                  textEditingController: content,
                  title: 'Nội dung chuyển khoản',
                  hint: '',
                  ontap: () async {
                    await onTap(
                        content.text, context, 'Copy nội dung thành công');
                  }),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.red,
                  ),
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, bottom: 16, top: 16),
                  child: Text(
                    'Đã thanh toán',
                    style: TextStyleManager.mediumBlack14px.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rootView(
      {required TextEditingController textEditingController,
      String? title,
      String? hint,
      required Function ontap}) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 75,
          child: MBPTextField(
            controller: textEditingController,
            hint: hint,
            title: title,
            textTitleStyle: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColors.red),
            textStyle: TextStyleManager.mediumBlack14px.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: AppColors.red),
            readOnly: true,
            onChanged: (_) {},
          ),
        ),
        GestureDetector(
          onTap: () {
            ontap();
          },
          child: Image.asset(
            Assets.icons.icCopy.path,
            width: 43,
            height: 36,
          ),
        )
      ],
    );
  }
}

onTap(String text, BuildContext context, String title) {
  Clipboard.setData(ClipboardData(text: text));
  ToastManager.showToast(
    context,
    text: title,
  );
}
