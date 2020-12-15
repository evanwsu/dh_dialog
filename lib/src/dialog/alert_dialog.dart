import 'package:flutter/material.dart';

import '../action_button.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../utils.dart';
import 'base_dialog.dart';

///@author Evan
///@since 2020/12/9
///@describe:

/// 标准提示框，用于提示一些信息
/// 可以设置标题和内容，支持取消和确认按键设置，也可设置其中一个
/// showDHDialog(
///    context: context,
///    builder: (BuildContext context){
///    return DHAlertDialog(
///    alignment: Alignment.bottomCenter,
///    titleText: "这是一个title",
///    contentText: "这是内容区域略略略略略",
///    positiveText: "确认",
///    negativeText: "取消"
///    );
///   }
/// );

class DHAlertDialog extends StatelessWidget {
  /// 标题控件
  final Widget title;

  /// 标题文本 作为[title]的一个备用控件实现[Text]
  /// 如果设置[title]，该项设置不起作用
  /// 标题文本样式请设置[titleTextStyle]
  final String titleText;

  /// 标题文本样式
  /// 如果设置[title]，该项设置不起作用
  final TextStyle titleTextStyle;

  /// 标题文本边距
  final EdgeInsetsGeometry titlePadding;

  /// 标题水平对齐方式
  final TextAlign titleAlign;

  /// 内容控件
  final Widget content;

  /// 内容文本，作为[content]的一个备用控件实现[Text]
  /// 如果设置[content]，该项设置不起作用
  /// 内容文本样式请设置[contentTextStyle]
  final String contentText;

  /// 内容文本样式
  /// 如果设置[content]，该项设置不起作用
  final TextStyle contentTextStyle;

  /// 内容部分边距
  final EdgeInsetsGeometry contentPadding;

  /// 内容水平对齐方式
  final TextAlign contentAlign;

  /// 肯定按钮文本
  final String positiveText;

  /// 肯定按钮文本样式
  /// 按钮高度请设置[actionHeight]
  final TextStyle positiveTextStyle;

  /// 肯定按钮点击事件
  final GestureTapCallback positiveTap;

  /// 右侧确定按钮，默认true
  final bool hasPositive;

  /// 否定按钮文本
  final String negativeText;

  /// 否定按钮文本样式
  /// 按钮高度请设置[actionHeight]
  final TextStyle negativeTextStyle;

  /// 否定按钮点击事件
  final GestureTapCallback negativeTap;

  /// 左侧取消按钮
  final bool hasNegative;

  /// 按钮高度设置
  final double actionHeight;

  /// 对话框有效部分背景颜色
  final Color backgroundColor;

  /// 分割线颜色，会作用在下面两部分
  /// 1.内容[content]部分和按钮[positiveAction] [negativeAction]间的分割线
  /// 2.多个按钮键的分割线
  final Color dividerColor;

  final double elevation;

  /// 对话框圆角
  final double circleRadius;

  /// 对话框的边距
  final EdgeInsetsGeometry dialogMargin;

  /// 对话框对齐方式
  final AlignmentGeometry alignment;

  DHAlertDialog(
      {Key key,
      this.title,
      this.titleText,
      this.titlePadding,
      this.titleTextStyle,
      this.titleAlign = TextAlign.center,
      this.content,
      this.contentText,
      this.contentPadding,
      this.contentTextStyle,
      this.contentAlign = TextAlign.center,
      this.positiveText,
      this.positiveTextStyle,
      this.positiveTap,
      this.negativeText,
      this.negativeTextStyle,
      this.negativeTap,
      this.circleRadius = 20.0,
      this.backgroundColor,
      this.elevation,
      this.dialogMargin,
      this.dividerColor = DHColors.color_000000_15,
      this.alignment = Alignment.center,
      this.actionHeight,
      this.hasNegative = true,
      this.hasPositive = true})
      : assert(alignment != null),
        assert(titleAlign != null),
        assert(contentAlign != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = title;
    Widget contentWidget = content;
    Widget dividerWidget;
    Widget actionWidget;
    List<Widget> actions = [];

    if (title == null && isNotEmpty(titleText)) {
      titleWidget = Text(
        titleText,
        textAlign: titleAlign,
      );
    }
    if (content == null && isNotEmpty(contentText)) {
      contentWidget = Text(
        contentText,
        textAlign: contentAlign,
      );
    }
    final radius = Radius.circular(circleRadius);

    if (hasNegative) {
      actions.add(Expanded(
          child: ActionButton(
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: radius,
                bottomRight: hasPositive ? Radius.zero : radius)),
        onTap: negativeTap ?? () => Navigator.pop(context),
        text: negativeText ?? 'Cancel',
        textStyle: negativeTextStyle ?? DialogStyle.negativeStyle,
      )));
    }

    // 添加分割线
    if (hasPositive && hasNegative)
      actions.add(Container(color: dividerColor, width: 1));

    if (hasPositive) {
      actions.add(Expanded(
        child: ActionButton(
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: hasNegative ? Radius.zero : radius,
                  bottomRight: radius)),
          text: positiveText ?? 'OK',
          textStyle: positiveTextStyle ?? DialogStyle.positiveStyle,
          onTap: positiveTap ?? () => Navigator.pop(context),
        ),
      ));
    }

    // 添加Action
    if (actions.isNotEmpty) {
      actionWidget = Container(
          height: actionHeight ?? DialogStyle.defaultActionHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions,
          ));
    }

    // 添加分割线
    if ((titleWidget != null || contentWidget != null) &&
        actionWidget != null) {
      dividerWidget = Container(
        color: dividerColor,
        height: 1,
      );
    }

    return DHDialog(
      title: titleWidget,
      titlePadding: titlePadding,
      titleTextStyle: titleTextStyle,
      content: contentWidget,
      contentPadding: contentPadding,
      contentTextStyle: contentTextStyle,
      action: actionWidget,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
      elevation: elevation,
      dialogMargin: dialogMargin,
      divider: dividerWidget,
      alignment: alignment,
    );
  }
}
