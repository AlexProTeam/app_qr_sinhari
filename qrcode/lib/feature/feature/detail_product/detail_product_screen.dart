import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/feature/feature/detail_product/detail_product_slide.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: 'Chi tiết sản phẩm',
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailProductSlide(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '(Sin hair) Dầu gội màu đen',
                    style: AppTextTheme.normalBlack,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset(
                        IconConst.fakeStar,
                        width: 80,
                        height: 15,
                      ),
                      Text(
                        ' 4,5',
                        style: AppTextTheme.normalBlack,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '370.000đ',
                    style: AppTextTheme.mediumBlack.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '''Dầu Gội Phủ Bạc Nhân Sâm Sin Hair

PHỦ BẠC TÓC TỪ LẦN GỘI ĐẦU TIÊN
NÓI KHÔNG VỚI HÓA CHẤT ĐỘC HẠI
15 PHÚT TẠI NHÀ – KHÔNG CẦN RA SALON
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
=> Chai dung tích 500ml , hạn sử dụng 3 năm

DẦU GỘI SIN HAIR số 1 Nhật Bản thành phần chính là Nhân Sâm và 100% thành phần thảo dược tự nhiên:
– Không gây kích ứng da, không dị ứng
– Lên màu nhanh chóng , không bị bay màu
– Hiệu quả từ lần gội đầu tiên

???? Hướng dẫn sử dụng :
-Để tóc khô hoặc ẩm, thoa đều dầu lên tóc kết hợp masage đến lúc ra bọt trắng sau đó chờ 10-15 phút rồi xả lại với nước.
-Tháng đầu tiên nên dùng mỗi tuần 1 lần. từ tháng thứ 2 dùng mỗi tháng 1 đến 2 lần nhé ạ''',
                    style: AppTextTheme.normalBlack,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
