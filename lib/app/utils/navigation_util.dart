import 'package:flutter/material.dart';

class NavigationUtil {
  static final GlobalKey<NavigatorState> _rootNavigator = GlobalKey();

  // For get current context. Can use rootKey.currentContext
  static GlobalKey<NavigatorState> get rootKey => _rootNavigator;

  static BuildContext? get currentContext => rootKey.currentContext;

  static final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> historyScanKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> scanKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> newsKey = GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> personalKey =
      GlobalKey<NavigatorState>();
}

class BottomTopPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final RouteSettings? routeSettings;

  BottomTopPageRoute({required this.builder, this.routeSettings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          settings: routeSettings,
        );
}

class NoAnimationMaterialPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final RouteSettings? routeSettings;
  final matchingBuilder = const CupertinoPageTransitionsBuilder();

  NoAnimationMaterialPageRoute({required this.builder, this.routeSettings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: Duration.zero, // Adjust the duration as needed
          reverseTransitionDuration:
              Duration.zero, // Adjust the duration as needed
          settings: routeSettings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Animation<double> fadeAnimation;
    final Widget animatedChild;

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0, 1),
      ),
    );

    animatedChild = FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );

    return animatedChild;
  }
}

class FadeInMaterialPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final RouteSettings? routeSettings;

  FadeInMaterialPageRoute({required this.builder, this.routeSettings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: const Duration(milliseconds: 10),
          reverseTransitionDuration: const Duration(milliseconds: 10),
          settings: routeSettings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Container(
      color: Colors.white, // Set the desired background color
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
