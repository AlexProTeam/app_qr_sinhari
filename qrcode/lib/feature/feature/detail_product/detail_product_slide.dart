import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/feature/themes/theme_color.dart';
import 'package:qrcode/feature/widgets/custom_image_network.dart';

const images = [
  'https://product.hstatic.net/200000192975/product/9_5ca9ca693ec04b15b7f08dc72b33fa92_master.jpg',
  'https://file.hstatic.net/200000192975/file/2_a42c30d719f9481ea73da7918365d87d_grande.png',
  'https://file.hstatic.net/200000192975/file/eu-qua-tai-nha-bang-gung-tuoi4_20668be1f32140e1ba1979b7d10baa9c_grande_981575db7cb441f09e408f5d381f2283_grande.png',
];

class DetailProductSlide extends StatefulWidget {
  const DetailProductSlide({Key? key}) : super(key: key);

  @override
  _DetailProductSlideState createState() => _DetailProductSlideState();
}

class _DetailProductSlideState extends State<DetailProductSlide> {
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
        Container(
          width: double.infinity,
          height: 250,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 4),
              viewportFraction: 1.0,
              reverse: false,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
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
                          ? AppColors.white
                          : AppColors.grey6,
                    ),
                  );
                }),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
