import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrcode/presentation/widgets/custom_image_network.dart';

import '../../../../../app/managers/color_manager.dart';

class DetailProductSlide extends StatefulWidget {
  final List<String>? images;

  const DetailProductSlide({Key? key, this.images}) : super(key: key);

  @override
  DetailProductSlideState createState() => DetailProductSlideState();
}

class DetailProductSlideState extends State<DetailProductSlide> {
  int _currentSlideIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300.h,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 4),
              viewportFraction: 1.0,
              reverse: false,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentSlideIndex = index;
                });
              },
            ),
            items: widget.images
                ?.map((e) => InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.transparent,
                        child: CustomImageNetwork(
                          url: e,
                          width: double.infinity,
                          height: 300.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 0,
          left: 0,
          child: Row(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(widget.images ?? [], (index, obj) {
                  return Container(
                    width: 8.r,
                    height: 8.r,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlideIndex == index
                          ? AppColors.white
                          : AppColors.grey6,
                    ),
                  );
                }),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
