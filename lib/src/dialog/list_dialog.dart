import 'package:dh_dialog/dh_dialog.dart';
import 'package:dh_dialog/src/action_button.dart';
import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../scroll_behavior.dart';
import '../utils.dart';
import 'base_dialog.dart';

///@author Evan
///@since 2020/12/9
///@describe:

typedef OnItemClickListener<T> = void Function(T data, int position);

/// List对话框条目模型
class DialogListItem<T> {
  final String text;
  final TextStyle textStyle;
  final T data;

  DialogListItem({
    @required this.text,
    this.textStyle,
    this.data,
  });
}

/// List对话框
class DHListDialog<T> extends StatelessWidget {
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

  final List<DialogListItem<T>> datas;

  /// 对话框有效部分背景颜色
  final Color backgroundColor;

  /// 分割线颜色，会作用在下面两部分
  /// 1.内容[content]部分和按钮[positiveAction] [negativeAction]间的分割线
  /// 2.多个按钮键的分割线
  final Color dividerColor;

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

  final EdgeInsetsGeometry itemPadding;
  
  final AlignmentGeometry itemAlignment;

  /// 对话框的边距
  final EdgeInsetsGeometry dialogMargin;

  /// 对话框对齐方式
  final AlignmentGeometry alignment;

  final double elevation;

  /// 对话框圆角
  final double circleRadius;

  final OnItemClickListener<T> itemClickListener;

  DHListDialog({
    Key key,
    this.title,
    this.titleText,
    this.titlePadding,
    this.titleTextStyle,
    this.titleAlign = TextAlign.center,
    @required this.datas,
    this.itemPadding = DialogStyle.listItemPadding,
    this.itemAlignment = Alignment.center,
    this.positiveText,
    this.positiveTextStyle,
    this.positiveTap,
    this.hasPositive = true,
    this.negativeText,
    this.negativeTextStyle,
    this.negativeTap,
    this.hasNegative = true,
    this.actionHeight,
    this.dialogMargin,
    this.backgroundColor,
    this.circleRadius = 20.0,
    this.elevation,
    this.dividerColor = DHColors.color_000000_15,
    this.alignment = Alignment.bottomCenter,
    this.itemClickListener,
  })  : assert(datas != null),
        assert(alignment != null),
        assert(itemPadding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = title;
    Widget contentWidget;
    Widget actionWidget;
    Widget dividerWidget;
    List<Widget> actions = [];

    if (title == null && isNotEmpty(titleText)) {
      titleWidget = Text(
        titleText,
        textAlign: titleAlign,
      );
    }

    final radius = Radius.circular(circleRadius);

    // content
    if (datas != null && datas.isNotEmpty) {
      contentWidget = ScrollConfiguration(
          behavior: NoneOverScrollBehavior(),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final item = datas[index];
              Widget itemWidget;
              if (itemClickListener == null) {
                itemWidget = Container(
                  alignment: itemAlignment,
                  padding: itemPadding,
                  child: Text(
                    item.text,
                    style: item.textStyle,
                  ),
                );
              } else {
                // 无标题第一个item 设置上部分圆角
                BorderRadius borderRadius;
                if (index == 0 && titleWidget == null) {
                  borderRadius = BorderRadius.vertical(top: radius);
                } else if (index == datas.length - 1 &&
                    (!hasNegative && !hasPositive)) {
                  borderRadius = BorderRadius.vertical(bottom: radius);
                }
                itemWidget = ActionButton(
                  customBorder: borderRadius != null
                      ? RoundedRectangleBorder(borderRadius: borderRadius)
                      : null,
                  innerPadding: itemPadding,
                  text: item.text,
                  textStyle: item.textStyle,
                  alignment: itemAlignment,
                  onTap: () => itemClickListener?.call(item.data, index),
                );
              }
              return itemWidget;
            },
            separatorBuilder: dividerColor == null
                ? null
                : (BuildContext context, int index) => Container(
                      color: dividerColor,
                      height: 1,
                    ),
            itemCount: datas.length,
          ));
    }

    // action
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
      contentPadding: EdgeInsets.zero,
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

// class DialogItemBuilder extends StatelessWidget{
//
//   final
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
//
// }