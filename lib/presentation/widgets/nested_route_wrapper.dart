import 'package:flutter/material.dart';

class NestedRouteWrapper extends StatefulWidget {
  final RouteFactory onGenerateRoute;
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Function(String routeName)? onChangeScreen;

  const NestedRouteWrapper({
    Key? key,
    required this.onGenerateRoute,
    required this.navigationKey,
    required this.initialRoute,
    this.onChangeScreen,
  }) : super(key: key);

  @override
  State<NestedRouteWrapper> createState() => _NestedRouteWrapperState();
}

class _NestedRouteWrapperState extends State<NestedRouteWrapper> {
  late ValueNotifier<String> routeName;

  @override
  void initState() {
    super.initState();
    routeName = ValueNotifier<String>(widget.initialRoute);
  }

  @override
  void dispose() {
    routeName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: routeName,
      child: Navigator(
        key: widget.navigationKey,
        initialRoute: widget.initialRoute,
        observers: [
          _CustomNavigatorObserver(
            onPop: (route) {
              final popRouteName = route?.settings.name;
              if (popRouteName != null) {
                routeName.value = popRouteName;
                if (widget.onChangeScreen != null) {
                  widget.onChangeScreen!(routeName.value);
                }
              }
            },
            onPush: (route) {
              final pushRouteName = route.settings.name;
              if (pushRouteName != null) {
                routeName.value = pushRouteName;
                if (widget.onChangeScreen != null) {
                  widget.onChangeScreen!(routeName.value);
                }
              }
            },
          ),
        ],
        onGenerateRoute: widget.onGenerateRoute,
      ),
      builder: (context, value, child) {
        return WillPopScope(
          onWillPop: value == widget.initialRoute
              ? null
              : () async {
                  final maybePop =
                      await widget.navigationKey.currentState?.maybePop() ??
                          true;

                  return !maybePop;
                },
          child: child!,
        );
      },
    );
  }
}

class _CustomNavigatorObserver extends NavigatorObserver {
  final Function(Route? route) onPop;
  final Function(Route route) onPush;

  _CustomNavigatorObserver({
    required this.onPop,
    required this.onPush,
  });

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    onPush(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onPop(previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      onPush(newRoute);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    onPop(previousRoute);
  }
}
