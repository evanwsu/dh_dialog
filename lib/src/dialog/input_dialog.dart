import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import '../res/colors.dart';
import '../res/styles.dart';
import 'alert_dialog.dart';

///@author Evan
///@since 2020/12/15
///@describe:
///输入对话框

enum InputBorderStyle {
  underline,
  outline,
  none,
}

class DHInputDialog extends StatefulWidget {
  /// 标题控件
  final Widget? title;

  /// 标题文本 作为[title]的一个备用控件实现[Text]
  /// 如果设置[title]，该项设置不起作用
  /// 标题文本样式请设置[titleTextStyle]
  final String? titleText;

  /// 标题文本样式
  /// 如果设置[title]，该项设置不起作用
  final TextStyle? titleTextStyle;

  /// 标题文本边距
  final EdgeInsetsGeometry? titlePadding;

  /// 标题水平对齐方式
  final TextAlign titleAlign;

  /// 内容部分边距
  final EdgeInsetsGeometry? contentPadding;

  /// 肯定按钮文本
  final String? positiveText;

  /// 肯定按钮文本样式
  /// 按钮高度请设置[actionHeight]
  final TextStyle? positiveTextStyle;

  /// 肯定按钮点击事件
  final ValueChanged<String>? positiveTap;

  /// 右侧确定按钮，默认true
  final bool hasPositive;

  /// 否定按钮文本
  final String? negativeText;

  /// 否定按钮文本样式
  /// 按钮高度请设置[actionHeight]
  final TextStyle? negativeTextStyle;

  /// 否定按钮点击事件
  final ValueChanged<String>? negativeTap;

  /// 左侧取消按钮
  final bool hasNegative;

  /// 按钮高度设置
  final double? actionHeight;

  /// 对话框有效部分背景颜色
  final Color? backgroundColor;

  /// 分割线颜色，可能作用在以下部分
  /// 1.listItem 分割线(未设置[itemDividerBuilder])
  /// 2.positiveAction 和 negativeAction分割线 (未设置[actionDividerBuilder])
  /// 3.listView和action 分割线(未设置[actionDividerBuilder])
  final Color? dividerColor;

  final double? elevation;

  /// 对话框圆角
  final double topRadius;

  /// 底部圆角
  final double bottomRadius;

  /// 对话框的边距
  final EdgeInsets? dialogMargin;

  final EdgeInsets? dialogPadding;

  /// 对话框对齐方式
  final AlignmentGeometry dialogAlignment;

  /// 对话框宽度
  final double? dialogWidth;

  /// action按钮间分割线，也包括listView 和 Action分割线
  /// 会覆盖[dividerColor]设置
  final DividerBuilder? actionDividerBuilder;

  /// 输入文本
  final String? text;

  /// 输入文本样式
  final TextStyle? style;

  /// 输入框装饰
  final InputDecoration? decoration;

  /// 输入框最大行数
  final int? maxLines;

  /// 输入内容格式化
  final List<TextInputFormatter>? inputFormatter;

  /// 输入法类型
  final TextInputType? keyboardType;

  /// 输入内容最大长度
  final int? maxLength;

  /// 输入框是否可用
  final bool? enabled;

  /// 提示文本
  final String? hintText;

  /// 提示文本样式
  final TextStyle? hintStyle;

  /// 边框样式，无边框[InputBorderStyle.none]，
  /// 下划线[InputBorderStyle.underline]，
  /// 矩形[InputBorderStyle.outline]
  final InputBorderStyle? borderStyle;

  /// 输入框内容填充
  final EdgeInsetsGeometry? inputPadding;

  /// 边框属性样式，设置边框颜色，边框宽度，有无边框
  final BorderSide? borderSide;

  /// 边框圆角半径
  final BorderRadius? borderRadius;

  /// 输入框背景是否填充颜色
  final bool? filled;

  /// 输入框背景填充颜色，[filled] 为true时工作
  final Color? fillColor;

  /// 输入框右侧控件
  final Widget? suffix;

  /// 输入框右侧点击事件，设置后[suffix]附加点击事件
  final GestureTapCallback? suffixOnTap;

  /// 输入框右侧控件大小约束
  final BoxConstraints? suffixConstraints;

  /// 是否显示文本统计，true必须设置[maxLength]才能工作
  final bool showCounter;

  /// 返回[TextEditingController]对象
  final ValueSetter<TextEditingController>? controllerGetter;

  DHInputDialog({
    Key? key,
    this.title,
    this.titleText,
    this.titlePadding,
    this.titleTextStyle,
    this.titleAlign = TextAlign.center,
    this.contentPadding,
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
    this.dialogPadding,
    this.backgroundColor,
    this.topRadius = 20.0,
    this.bottomRadius = 20.0,
    this.elevation,
    this.dividerColor = DHColors.color_000000_15,
    this.actionDividerBuilder,
    this.dialogAlignment = Alignment.bottomCenter,
    this.dialogWidth,
    this.text,
    this.style,
    this.maxLines = 1,
    this.inputFormatter,
    this.keyboardType,
    this.maxLength,
    this.enabled,
    this.decoration,
    this.hintText,
    this.hintStyle,
    this.borderStyle = InputBorderStyle.outline,
    this.filled = true,
    this.fillColor = DHColors.color_f8f8f8,
    this.inputPadding = DialogStyle.inputPadding,
    this.borderSide,
    this.borderRadius,
    this.showCounter = false,
    this.suffix,
    this.suffixOnTap,
    this.suffixConstraints,
    this.controllerGetter,
  }) : super(key: key);

  @override
  _DHInputDialogState createState() => _DHInputDialogState();
}

class _DHInputDialogState extends State<DHInputDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    String? text = widget.text;
    if (text != null && text.isNotEmpty) _controller.text = text;

    widget.controllerGetter?.call(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DHInputDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.text = widget.text ?? '';
    }
    widget.controllerGetter?.call(_controller);
  }

  @override
  Widget build(BuildContext context) {
    InputBorder? border;
    if (widget.borderStyle == InputBorderStyle.none) {
      border = InputBorder.none;
    } else if (widget.borderStyle == InputBorderStyle.underline) {
      border = UnderlineInputBorder(
        borderSide: widget.borderSide ?? DialogStyle.inputBorderSide,
        borderRadius: widget.borderRadius ?? DialogStyle.underlineBorderRadius,
      );
    } else if (widget.borderStyle == InputBorderStyle.outline) {
      border = OutlineInputBorder(
          gapPadding: .0,
          borderSide: widget.borderSide ?? DialogStyle.inputBorderSide,
          borderRadius: widget.borderRadius ?? DialogStyle.outlineBorderRadius);
    }

    //包裹suffix手势监听
    Widget? suffix = widget.suffix;
    if (suffix != null && widget.suffixOnTap != null) {
      suffix = GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: suffix,
        ),
        onTap: widget.suffixOnTap,
      );
    }

    BoxConstraints? suffixConstraints;
    if (suffix != null) {
      suffixConstraints = widget.suffixConstraints ??
          BoxConstraints.tight(DialogStyle.suffixSize);
    }

    Widget content = TextField(
      style: widget.style,
      textAlignVertical: TextAlignVertical.center,
      controller: _controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatter,
      autofocus: true,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      decoration: widget.decoration ??
          InputDecoration(
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            focusedErrorBorder: border,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            fillColor: widget.fillColor,
            filled: widget.filled,
            isDense: true,
            counterText: widget.showCounter ? null : "",
            contentPadding: widget.inputPadding,
            suffixIcon: suffix,
            suffixIconConstraints: suffixConstraints,
          ),
    );

    GestureTapCallback? positiveTap, negativeTap;
    if (widget.positiveTap != null) {
      positiveTap = () => widget.positiveTap!(_controller.text);
    }
    if (widget.negativeTap != null) {
      negativeTap = () => widget.negativeTap!(_controller.text);
    }

    return DHAlertDialog(
      key: widget.key,
      title: widget.title,
      titleText: widget.titleText,
      titlePadding: widget.titlePadding,
      titleTextStyle: widget.titleTextStyle,
      titleAlign: widget.titleAlign,
      content: content,
      contentPadding: widget.contentPadding,
      positiveText: widget.positiveText,
      positiveTextStyle: widget.positiveTextStyle,
      positiveTap: positiveTap,
      hasPositive: widget.hasPositive,
      negativeText: widget.negativeText,
      negativeTextStyle: widget.negativeTextStyle,
      negativeTap: negativeTap,
      hasNegative: widget.hasNegative,
      actionHeight: widget.actionHeight,
      dialogMargin: widget.dialogMargin,
      dialogPadding: widget.dialogPadding,
      backgroundColor: widget.backgroundColor,
      topRadius: widget.topRadius,
      bottomRadius: widget.bottomRadius,
      elevation: widget.elevation,
      dividerColor: widget.dividerColor,
      actionDividerBuilder: widget.actionDividerBuilder,
      dialogAlignment: widget.dialogAlignment,
      dialogWidth: widget.dialogWidth,
    );
  }
}
