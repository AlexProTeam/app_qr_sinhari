import 'dart:io';

import 'package:flutter/material.dart';

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
    return (path == null || path == '')
        ? ClipOval(
            child: Image.asset(
              '',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          )
        : ClipOval(
            child: Image.asset(
              path ?? '',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          );
    // CircleAvatar(
    //         radius: size / 2,
    //         foregroundImage: FileImage(
    //           File(path!),
    //         ),
    //         backgroundColor: Colors.transparent,
    //         backgroundImage: const AssetImage(
    //           'assets/images/ic_avatar_default.png',
    //           package: 'mbpcomponents',
    //         ),
    //       );
  }
}
