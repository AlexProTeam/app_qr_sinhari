import 'package:flutter/material.dart';
import 'package:qrcode/common/const/icon_constant.dart';
import 'package:qrcode/common/navigation/route_names.dart';
import 'package:qrcode/feature/routes.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/themes/theme_text.dart';
import 'package:qrcode/feature/widgets/banner_slide_image.dart';
import 'package:qrcode/feature/widgets/custom_gesturedetactor.dart';
import 'package:qrcode/feature/widgets/custom_scaffold.dart';
import 'package:qrcode/feature/widgets/gridview_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomGestureDetector(
                  onTap: (){
                    Routes.instance.navigateTo(RouteName.PersonalScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        IconConst.logo,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        IconConst.scan,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: BannerSlideImage(
                height: 183,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 12),
                Text('Sản phẩm nổi bật',style: AppTextTheme.mediumBlack,),
                const Spacer(),
                CustomGestureDetector(
                  onTap: (){
                    Routes.instance.navigateTo(RouteName.ListProductScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: Text('Xem thêm'),
                  ),
                ),
              ],
            ),
            GridViewDisplayProduct(),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 12),
                Text('Sản phẩm bán chạy',style: AppTextTheme.mediumBlack,),
                const Spacer(),
                CustomGestureDetector(
                  onTap: (){
                    Routes.instance.navigateTo(RouteName.ListProductScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: Text('Xem thêm'),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            GridViewDisplayProduct(),
          ],
        ),
      ),
    );
  }
}
