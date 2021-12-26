
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'widget_cached_image_error.dart';

class WidgetCachedImage extends StatelessWidget {
  WidgetCachedImage({this.url, this.color, this.fit});

  final String? url;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: url!,
        placeholder: (context, url) {
          return Center(
            child: Container(
              height: 100,
              width: 100,
              child: Image.asset("assets/icons/logo.png"),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Center(child: WidgetCachedImageError());
        },
        color: color,
        fit: fit ?? BoxFit.fill,
        filterQuality: FilterQuality.low,
      ),
    );
  }
}
