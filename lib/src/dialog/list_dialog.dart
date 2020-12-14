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

/// List对话框条目模型
class DialogListItem {
  final String title;
  final TextStyle textStyle;
  final GestureTapCallback onTap;

  DialogListItem({
    @required this.title,
    this.textStyle,
    this.onTap,
  });
}

/// List对话框
class DHListDialog extends StatelessWidget {
  /// 标题栏
  final Widget title;

  /// 标题栏边距
  final EdgeInsetsGeometry titlePadding;

  /// 标题栏文本样式
  final TextStyle titleTextStyle;

  final List<DialogListItem> datas;

  final double circleRadius;

  /// 分割线颜色
  final Color dividerColor;

  /// 对话框对齐方式
  final AlignmentGeometry alignment;

  /// action 文本
  final String actionText;

  /// action 文本样式
  final TextStyle actionTextStyle;

  /// action 文本点击事件
  final GestureTapCallback actionTap;

  /// 按钮高度设置
  final EdgeInsetsGeometry actionPadding;

  /// 对话框有效部分背景颜色
  final Color backgroundColor;

  /// 对话框的边距
  final EdgeInsetsGeometry dialogPadding;

  final double elevation;

  final EdgeInsetsGeometry itemPadding;

  DHListDialog({
    Key key,
    this.title,
    this.titleTextStyle,
    this.titlePadding,
    @required this.datas,
    this.itemPadding = DialogStyle.listItemPadding,
    this.actionText,
    this.actionTextStyle,
    this.actionTap,
    this.actionPadding,
    this.backgroundColor,
    this.circleRadius = 20.0,
    this.elevation,
    this.dividerColor = DHColors.color_000000_15,
    this.alignment = Alignment.bottomCenter,
    this.dialogPadding,
  })  : assert(datas != null),
        assert(alignment != null),
        assert(itemPadding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(circleRadius);

    Widget actionWidget;
    Widget contentWidget;
    if (datas != null && datas.isNotEmpty) {
      contentWidget = ScrollConfiguration(
          behavior: NoneOverScrollBehavior(),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final item = datas[index];
              Widget itemWidget;
              if (item.onTap == null) {
                itemWidget = Container(
                  padding: itemPadding,
                  alignment: Alignment.center,
                  child: Text(
                    item.title,
                    style: item.textStyle,
                  ),
                );
              } else {
                // 无标题第一个item 设置上部分圆角
                BorderRadius borderRadius;
                if (index == 0 &&  title == null) {
                  borderRadius = BorderRadius.vertical(top: radius);
                } else if (index == datas.length - 1 &&
                    isEmpty(actionText)) {
                  borderRadius = BorderRadius.vertical(bottom: radius);
                }
                itemWidget = ActionButton(
                  customBorder: borderRadius != null
                      ? RoundedRectangleBorder(borderRadius: borderRadius)
                      : null,
                  innerPadding: itemPadding,
                  text: item.title,
                  textStyle: item.textStyle,
                  onTap: item.onTap,
                );
              }
              return itemWidget;
            },
            separatorBuilder: (BuildContext context, int index) => Container(
              color: dividerColor,
              height: 1,
            ),
            itemCount: datas.length,
          ));
    }

    if (isNotEmpty(actionText)) {
      actionWidget = ActionButton(
        text: actionText,
        textStyle: actionTextStyle ?? DialogStyle.positiveStyle,
        innerPadding: actionPadding ?? DialogStyle.actionPadding,
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: radius,
        )),
        onTap: () {
          Navigator.pop(context);
          actionTap?.call();
        },
      );
    }

    return DHDialog(
      title: title,
      titleTextStyle: titleTextStyle,
      titlePadding: titlePadding,
      content: contentWidget,
      contentPadding: EdgeInsets.zero,
      action: actionWidget,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
      elevation: elevation,
      dialogMargin: dialogPadding,
      divider: Container(
        color: dividerColor,
        height: 1,
      ),
      alignment: alignment,
    );
  }
}
