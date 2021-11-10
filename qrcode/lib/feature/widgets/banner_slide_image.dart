import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

const images = [
  'https://product.hstatic.net/200000192975/product/9_5ca9ca693ec04b15b7f08dc72b33fa92_master.jpg',
  'https://file.hstatic.net/200000192975/file/2_a42c30d719f9481ea73da7918365d87d_grande.png',
  'https://file.hstatic.net/200000192975/file/eu-qua-tai-nha-bang-gung-tuoi4_20668be1f32140e1ba1979b7d10baa9c_grande_981575db7cb441f09e408f5d381f2283_grande.png',
];

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
      this.fit})
      : super(key: key);

  @override
  _BannerSlideImageState createState() => _BannerSlideImageState();
}

class _BannerSlideImageState extends State<BannerSlideImage> {
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
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: widget.height ?? 248.0,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              autoPlay: true,
              autoPlayAnimationDuration:
                  widget.duration ?? Duration(seconds: 3),
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
            items: images
                .map((e) => InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.transparent,
                        child: CustomImageNetwork(
                          url: e,
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
        const SizedBox(height: 12),
        Row(
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(images, (index, obj) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentSlideIndex == index
                        ? AppColors.primaryColor
                        : AppColors.grey4,
                  ),
                );
              }),
            ),
            Spacer(),
          ],
        )
      ],
    );
  }
}
