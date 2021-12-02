import 'package:flutter/widgets.dart';

extension WidgetModifier on Widget {
  Widget padding({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
        child: this,
        padding: EdgeInsets.only(
            left: left, right: right, top: top, bottom: bottom));
  }
}
