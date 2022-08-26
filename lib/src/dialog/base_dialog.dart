import 'package:flutter/material.dart';

import '../res/styles.dart';

///@author Evan
///@since 2020-03-13
///@describe:
/// 对话框按照下面顺序排列
/// 1. title  标题
/// 2. content 内容
/// 3. divider 内容和按钮分割线
/// 4. action 按钮

/// 对话框控件
class DHDialog extends StatelessWidget {
  /// 标题控件
  final Widget? title;

  /// 标题控件的填充大小
  final EdgeInsetsGeometry? titlePadding;

  /// 标题文本样式
  final TextStyle? titleTextStyle;

  /// title 和 content之间分割线
  final Widget? titleDivider;

  /// 内容控件
  final Widget? content;

  /// 内容控件的填充大小
  final EdgeInsetsGeometry? contentPadding;

  /// 内容文本样式
  final TextStyle? contentTextStyle;

  /// 按钮控件
  final Widget? action;

  /// actions 和 content之间的分割线
  final Widget? actionDivider;

  /// 对话框边框形状
  final ShapeBorder? shape;

  /// 对话框背景颜色
  final Color? backgroundColor;

  /// 对话框阴影Z轴高度
  final double? elevation;

  /// 对话框边距
  final EdgeInsets? dialogMargin;

  final EdgeInsets? dialogPadding;

  /// 对话框宽度
  final double? dialogWidth;

  /// 对话框对齐方式
  final AlignmentGeometry dialogAlignment;

  DHDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.titleDivider,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.action,
    this.actionDivider,
    this.backgroundColor,
    this.shape,
    this.elevation,
    this.dialogMargin,
    this.dialogPadding,
    this.dialogWidth,
    this.dialogAlignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? titleWidget;

    if (title != null) {
      titleWidget = Padding(
        padding: titlePadding ??
            EdgeInsets.fromLTRB(
                24.0, 24.0, 24.0, content == null ? 24.0 : 16.0),
        child: DefaultTextStyle(
          style: titleTextStyle ?? DialogStyle.titleStyle,
          child: title!,
        ),
      );
    }

    Widget? contentWidget;
    if (content != null)
      contentWidget = Padding(
        padding: contentPadding ??
            EdgeInsets.fromLTRB(
              24.0,
              title == null ? 24.0 : .0,
              24.0,
              action == null ? MediaQuery.of(context).padding.bottom : 24.0,
            ),
        child: DefaultTextStyle(
          style: contentTextStyle ?? DialogStyle.contentStyle,
          child: content!,
        ),
      );

    List<Widget> children = <Widget>[
      if (titleWidget != null) titleWidget,
      if (titleDivider != null) titleDivider!,
      if (contentWidget != null) Flexible(child: contentWidget),
      if (actionDivider != null) actionDivider!,
      if (action != null) action!,
    ];

    Widget? dialog;
    if (children.isNotEmpty) {
      dialog = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    }

    return BaseDialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      dialogMargin: dialogMargin,
      dialogAlignment: dialogAlignment,
      dialogPadding: dialogPadding,
      shape: shape,
      child: dialog,
      dialogWidth: dialogWidth,
    );
  }
}

/// 通用的dialog
/// [DHDialog] 基于此实现
class BaseDialog extends StatelessWidget {
  /// 默认圆角边框
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)));
  static const double _defaultElevation = 24.0;

  /// 对话框边框形状
  final ShapeBorder? shape;

  /// 对话框背景颜色
  final Color? backgroundColor;

  /// 对话框阴影Z轴高度
  final double? elevation;

  /// 对话框边距
  final EdgeInsets? dialogMargin;

  /// 对话框padding
  final EdgeInsets? dialogPadding;

  /// 对话框对齐方式
  final AlignmentGeometry dialogAlignment;

  /// 子控件
  final Widget? child;

  /// 最大宽度
  final double? dialogWidth;

  BaseDialog({
    Key? key,
    this.child,
    this.backgroundColor,
    this.shape,
    this.elevation,
    this.dialogMargin,
    this.dialogAlignment = Alignment.center,
    this.dialogWidth,
    this.dialogPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialogMargin = this.dialogMargin ?? DialogStyle.dialogMargin;
    final DialogTheme dialogTheme = DialogTheme.of(context);
    double? maxWidth = this.dialogWidth;

    if (maxWidth == null) {
      final width = MediaQuery.of(context).size.width;
      final isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait;
      maxWidth = isPortrait ? double.infinity : width * 0.6;
    }

    Widget? child = this.child;
    if (dialogPadding != null) {
      child = Padding(
        padding: dialogPadding!,
        child: this.child,
      );
    }

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + dialogMargin,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          alignment: dialogAlignment,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 280.0, maxWidth: maxWidth),
            child: Material(
              color: backgroundColor ?? dialogTheme.backgroundColor,
              elevation:
                  elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
