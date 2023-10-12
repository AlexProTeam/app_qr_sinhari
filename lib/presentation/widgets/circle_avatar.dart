import 'package:flutter/material.dart';
import 'package:qrcode/presentation/widgets/custom_image_network.dart';

class CircleAvatarWidget extends StatelessWidget {
  final double size;
  final BoxFit? fit;
  final String? imageUrl;
  final String? path;

  const CircleAvatarWidget(
      {Key? key, this.size = 0, this.fit, this.imageUrl, this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CustomImageNetwork(
        url: imageUrl ?? '',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
