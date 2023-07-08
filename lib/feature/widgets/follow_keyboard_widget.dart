import 'package:flutter/material.dart';

class FollowKeyBoardWidget extends StatefulWidget {
  final Widget child;
  final Widget? bottomWidget;
  final double scaleTo;

  const FollowKeyBoardWidget({
    required this.child,
    Key? key,
    this.bottomWidget,
    this.scaleTo = 30.0,
  }) : super(key: key);

  @override
  FollowKeyBoardWidgetState createState() => FollowKeyBoardWidgetState();
}

class FollowKeyBoardWidgetState extends State<FollowKeyBoardWidget> {
  double mouseRegion = 0;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MouseRegion(
        onHover: (data) {
          mouseRegion =
              mediaQuery.size.height - data.position.dy + widget.scaleTo;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: widget.child),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: widget.bottomWidget ?? const SizedBox(),
            ),
            SizedBox(
              height: _viewInsertPadding,
            ),
          ],
        ),
      ),
    );
  }

  double get _viewInsertPadding => MediaQuery.of(context).viewInsets.bottom;
}
