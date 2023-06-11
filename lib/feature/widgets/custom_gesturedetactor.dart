import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const CustomGestureDetector({Key? key, required this.onTap, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
