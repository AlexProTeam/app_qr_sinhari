import 'package:flutter/material.dart';
import 'package:qrcode/app/managers/color_manager.dart';
import 'package:qrcode/app/route/navigation/route_names.dart';
import 'package:qrcode/gen/assets.gen.dart';
import 'package:qrcode/presentation/widgets/circle_avatar.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatarWidget(
          size: 80,
          path: Assets.images.welcome.path,
        ),
        const Text(
          '0968506638',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        Text(
          'Chí Bảo',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.black.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteDefine.historyDetb,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.color0A55BA, width: 1)),
                  child: Row(
                    children: [
                      Image.asset(Assets.icons.iconBank.path),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '10.000.000 VND',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.color2604F5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteDefine.payDebt,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.color0A55BA, width: 1)),
                  child: Image.asset(Assets.icons.iconQr.path),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
