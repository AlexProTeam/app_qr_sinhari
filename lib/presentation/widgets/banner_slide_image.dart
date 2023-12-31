import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/domain/entity/banner_model.dart';

import '../../app/managers/color_manager.dart';
import '../../app/managers/route_names.dart';
import 'custom_image_network.dart';

class BannerSlideImage extends StatefulWidget {
  final double? borderRadius;
  final double? height;
  final Widget? displayNumberImage;
  final bool autoPlay;
  final bool revert;
  final Duration? duration;
  final bool enableInfiniteScroll;
  final Function(int index)? onchangePage;
  final BoxFit? fit;
  final List<String>? images;
  final List<BannerResponse>? banners;

  const BannerSlideImage(
      {Key? key,
      this.borderRadius = 0,
      this.height,
      this.displayNumberImage,
      this.autoPlay = false,
      this.revert = false,
      this.duration,
      this.enableInfiniteScroll = false,
      this.onchangePage,
      this.images,
      this.banners,
      this.fit})
      : super(key: key);

  @override
  BannerSlideImageState createState() => BannerSlideImageState();
}

class BannerSlideImageState extends State<BannerSlideImage> {
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
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: widget.height ?? 248.0,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              autoPlay: true,
              autoPlayAnimationDuration: widget.duration ??
                  Duration(seconds: (widget.images ?? []).length + 1),
              viewportFraction: 1.0,
              reverse: widget.revert,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                if (widget.onchangePage != null) {
                  widget.onchangePage!(index);
                }
                setState(() {
                  _currentSlideIndex = index;
                });
              },
            ),
            items: widget.banners
                ?.map((e) => InkWell(
                      onTap: () {
                        if (e.urlLink != null &&
                            (e.urlLink?.contains('http') ?? false)) {
                          Navigator.pushNamed(
                            context,
                            RouteDefine.webViewScreen,
                            arguments: e.urlLink,
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.transparent,
                        child: CustomImageNetwork(
                          url: e.url,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          border: 12,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(widget.images ?? [], (index, obj) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentSlideIndex == index
                      ? AppColors.white
                      : AppColors.grey4,
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
