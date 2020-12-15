import 'package:flutter/material.dart';
import '../res/styles.dart';

///@author Evan
///@since 2020-03-13
///@describe:
///

/// 对话框控件
class DHDialog extends StatelessWidget {
  final Widget title;
  final EdgeInsetsGeometry titlePadding;
  final TextStyle titleTextStyle;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle contentTextStyle;
  final Widget action;
  final ShapeBorder shape;
  final Color backgroundColor;
  final double elevation;

  /// 对话框padding
  final EdgeInsetsGeometry dialogMargin;

  /// actions  和 content之间的分割线
  final Widget divider;
  final AlignmentGeometry dialogAlignment;

  DHDialog(
      {Key key,
      this.title,
      this.titlePadding,
      this.titleTextStyle,
      this.content,
      this.contentPadding,
      this.contentTextStyle,
      this.action,
      this.backgroundColor,
      this.shape,
      this.elevation,
      this.dialogMargin,
      this.divider,
      this.dialogAlignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleWidget;


    if (title != null){
      titleWidget = Padding(
        padding: titlePadding ?? EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 24.0 : 16.0),
        child: DefaultTextStyle(
          style: titleTextStyle ?? DialogStyle.titleStyle,
          child: title,
        ),
      );
    }

    Widget contentWidget;
    if (content != null)
      contentWidget = Padding(
        padding: contentPadding ?? EdgeInsets.fromLTRB(24.0, title == null ? 24.0 : .0, 24.0, 24.0),
        child: DefaultTextStyle(
          style: contentTextStyle ?? DialogStyle.contentStyle,
          child: content,
        ),
      );

    List<Widget> children = <Widget>[
      if (titleWidget != null) titleWidget,
      if (contentWidget != null) Flexible(child: contentWidget),
      if (divider != null) divider,
      if (action != null) action,
    ];

    Widget dialog;
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
        shape: shape,
        child: dialog);
  }
}

/// 通用的dialog
/// [DHDialog] 基于此实现
class BaseDialog extends StatelessWidget {
  /// 圆角边框
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)));
  static const double _defaultElevation = 24.0;

  final ShapeBorder shape;
  final Color backgroundColor;
  final double elevation;

  /// 对话框padding
  final EdgeInsetsGeometry dialogMargin;
  final AlignmentGeometry dialogAlignment;
  final Widget child;

  BaseDialog(
      {Key key,
      this.child,
      this.backgroundColor,
      this.shape,
      this.elevation,
      this.dialogMargin,
      this.dialogAlignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dialogMargin = this.dialogMargin ?? DialogStyle.dialogMargin;
    final DialogTheme dialogTheme = DialogTheme.of(context);

    final width = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double maxWidth = isPortrait ? double.infinity : width * 0.6;

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
