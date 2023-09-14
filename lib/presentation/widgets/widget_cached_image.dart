import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'widget_cached_image_error.dart';

class WidgetCachedImage extends StatelessWidget {
  const WidgetCachedImage({Key? key, this.url, this.color, this.fit})
      : super(key: key);

  final String? url;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url!,
      placeholder: (context, url) {
        return Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset("assets/icons/logo.png"),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return const Center(child: WidgetCachedImageError());
      },
      color: color,
      fit: fit ?? BoxFit.fill,
      filterQuality: FilterQuality.low,
    );
  }
}
