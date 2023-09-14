import 'package:flutter/material.dart';

class SlideLeftRoute extends PageRouteBuilder {
  final Widget? widget;
  int duration;

  SlideLeftRoute({@required this.widget, this.duration = 200})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget??const SizedBox();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero)
                      .animate(animation),
              child: child,
            );
          },
        );

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);
}
