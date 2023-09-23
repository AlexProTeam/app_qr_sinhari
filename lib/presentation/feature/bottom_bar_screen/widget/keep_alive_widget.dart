import 'package:flutter/cupertino.dart';

class LayoutContainWidgetKeepAlive extends StatefulWidget {
  final Widget child;

  const LayoutContainWidgetKeepAlive({Key? key, required this.child})
      : super(key: key);

  @override
  LayoutContainWidgetKeepAliveState createState() =>
      LayoutContainWidgetKeepAliveState();
}

class LayoutContainWidgetKeepAliveState
    extends State<LayoutContainWidgetKeepAlive>
    with AutomaticKeepAliveClientMixin<LayoutContainWidgetKeepAlive> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
