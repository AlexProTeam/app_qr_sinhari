import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';

import '../../../../common/utils/common_util.dart';
import '../../../themes/theme_color.dart';
import '../../../widgets/box_border_widget.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/icon_text_widget.dart';
import '../../../widgets/icon_tiltile_value_widget.dart';
import '../enum/personal_menu_enum.dart';

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
                  titleValueWidget(
                    icon: IconConst.location,
                    title: 'Trụ sở: ',
                    value:
                        'T1 331B đường Bát Khối, Phường Long Biên, Quận Long Biên,Thành phố Hà Nội, Việt Nam',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            boxBorderApp(
              child: titleValueWidget(
                icon: IconConst.hotline,
                title: 'Hotline: ',
                value: '19003065',
              ),
            ),
            const SizedBox(height: 12),
            boxBorderApp(
              child: titleValueWidget(
                icon: IconConst.mail,
                title: 'Email: ',
                value: 'info@sinhairvietnam.vn',
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
