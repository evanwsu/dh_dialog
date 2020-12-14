import 'package:flutter/widgets.dart';

///@author Evan
///@since 2019-10-21
///@describe: 禁止滑动窗口效果

class NoneOverScrollBehavior extends ScrollBehavior{

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => ClampingScrollPhysics();
}