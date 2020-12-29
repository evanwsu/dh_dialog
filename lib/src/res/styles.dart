import 'package:flutter/painting.dart';

import 'colors.dart';

class DialogStyle{
  DialogStyle._();

  static const double actionHeight = 49.0;
  static const double itemHeight = 48.0;

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
    vertical: 17, horizontal: 24
  );

  static const EdgeInsetsGeometry listItemHorizontal = EdgeInsets.symmetric(
      horizontal: 24
  );

  static const EdgeInsetsGeometry dialogMargin = EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

  static const TextStyle inputTextStyle = TextStyle(
      color: DHColors.color_333333,
      fontSize: 14
  );


  /// input dialog 输入框内容填充
  static const EdgeInsetsGeometry inputPadding = EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0);

  /// input dialog [borderStyle]是InputBorderStyle.outline
  /// 边框圆角属性[borderRadius]
  static const BorderRadius outlineBorderRadius = BorderRadius.all(Radius.circular(6.0));

  /// input dialog [borderStyle]是InputBorderStyle.underline
  /// 边框圆角属性[borderRadius]
  static const BorderRadius underlineBorderRadius = BorderRadius.vertical(top: Radius.circular(6.0));

  static const BorderSide inputBorderSide = BorderSide(color: DHColors.color_000000_15);

  static const Size suffixSize = Size(40, 40);
}