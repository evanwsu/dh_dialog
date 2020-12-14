import 'package:dh_dialog/src/res/colors.dart';
import 'package:flutter/painting.dart';

class DialogStyle{
  DialogStyle._();

  /// 对话框标题文本样式
  static const TextStyle titleStyle = TextStyle(
    color: DHColors.color_333333,
    fontSize: 16
  );

  /// 对话框内容文本样式
  static const TextStyle contentStyle = TextStyle(
    color: DHColors.color_666666,
    fontSize: 14
  );

  /// 对话框取消按钮文本样式
  static const TextStyle negativeStyle = TextStyle(
    color: DHColors.color_666666,
    fontSize: 14
  );

  /// 对话框确认按钮文本样式
  static const TextStyle positiveStyle = TextStyle(
      color: DHColors.color_000000,
      fontSize: 14
  );

  static const EdgeInsetsGeometry listItemPadding = EdgeInsets.symmetric(
    vertical: 18, horizontal: 24
  );

  static const EdgeInsetsGeometry actionPadding = listItemPadding;

  static const EdgeInsetsGeometry dialogMargin = EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

}