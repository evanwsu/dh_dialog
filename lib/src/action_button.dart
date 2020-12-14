import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  /// 控件宽度
  final double width;
  /// 控件高度
  final double height;
  /// 按钮背景颜色
  final Color backgroundColor;
  /// 按钮背景装饰
  final Decoration decoration;
  /// 按钮周边填充
  final EdgeInsetsGeometry padding;
  /// 按钮点击事件
  final GestureTapCallback onTap;
  /// 是否可用
  final bool disabled;
  /// 文本 设置后等同文本按钮
  final String text;
  /// 图片 设置后等同图片按钮
  /// 文本样式
  final TextStyle textStyle;
  /// 波纹背景形状
  final ShapeBorder customBorder;
  /// 控件内部padding, 包裹在child外层
  final EdgeInsetsGeometry innerPadding;

  ActionButton({
    this.width,
    this.height,
    this.backgroundColor,
    this.padding,
    this.decoration,
    this.onTap,
    this.disabled = false,
    this.text,
    this.textStyle,
    this.customBorder,
    this.innerPadding,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Text(
      text ?? "",
      style: textStyle,
      maxLines: 1,
      overflow: TextOverflow.clip,
    );

    if(innerPadding != null){
      child = Padding(
        padding: innerPadding,
        child: child,
      );
    }

    return Material(
      color: Colors.transparent,
      child: Ink(
        width: width,
        height: height,
        decoration: decoration,
        color: backgroundColor,
        padding: padding,
        child: InkWell(
          onTap: disabled ? null : onTap,
          customBorder: customBorder,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
