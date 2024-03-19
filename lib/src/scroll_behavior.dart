import 'package:flutter/widgets.dart';

///@author Evan
///@since 2019-10-21
///@describe: 禁止滑动窗口效果

class NoneOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
