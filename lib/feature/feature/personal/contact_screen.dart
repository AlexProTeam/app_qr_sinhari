import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';

import '../../../common/utils/common_util.dart';
import '../../themes/theme_color.dart';
import '../../widgets/box_border_widget.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/icon_text_widget.dart';
import 'enum/personal_menu_enum.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  WebviewScreenState createState() => WebviewScreenState();
}

class WebviewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Liên hệ',
        isShowBack: true,
      ),
      backgroundColor: AppColors.bgrScafold,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Image.asset(
              IconConst.logoLogin,
              width: 140,
              height: 140,
            ),
            const SizedBox(height: 10),
            boxBorderApp(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconConst.location,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 15),
                      RichText(
                          text: const TextSpan(
                              children: [
                            TextSpan(
                              text: ' 192 Mai Anh Tuấn, Quận\n Ba Đình, Hà Nội',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          ],
                              text: 'Trụ sở:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)))
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const SizedBox(width: 39),
                      RichText(
                          text: const TextSpan(
                              text: 'Văn phòng HCM:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              children: [
                            TextSpan(
                                text:
                                    ' Số nhà 76 Lê\n Lai, Quận 1, Tp Hồ Chí Minh',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black))
                          ])),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            boxBorderApp(
                child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      IconConst.hotline,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 15),
                    RichText(
                        text: const TextSpan(
                            children: [
                          TextSpan(
                              text: '19008787',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ))
                        ],
                            text: 'Hotline: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)))
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    SizedBox(width: 39),
                    Text(
                      'VP HCM: 0987 655 755',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            )),
            const SizedBox(height: 12),
            boxBorderApp(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    IconConst.mail,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 15),
                  RichText(
                      text: const TextSpan(
                    text: 'Email:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.35),
                    children: [
                      TextSpan(
                          text: ' sunhair.cskh@gmail.com',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ))
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: 12),
            boxBorderApp(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Kết nối với Sinhair:',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                ),
                ...AppContact.values.map(
                  (e) => iconTextWidget(
                    onTap: () => CommonUtil.runUrl(e.getLongContact),
                    text: e.getShortContact,
                    iconWidget: e.getIcon(),
                    iconData: '',
                  ),
                ),
                const SizedBox(height: 17),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
