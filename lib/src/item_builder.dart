import 'package:flutter/widgets.dart';

import 'action_button.dart';
import 'selected.dart';

///@author Evan
///@since 2020/12/15
///@describe:

/// 文本条目数据模型
/// 依照模型创建[ItemTextBuilder]
class TextItem {
  final String text;
  final TextStyle textStyle;

  TextItem({
    @required this.text,
    this.textStyle,
  });
}

/// 选择条目base模型
/// 所有选择条目应该继承它
class BaseChoiceItem {
  bool selected;
  BaseChoiceItem(this.selected);
}

/// 选择条目数据模型
/// 默认支持图片和文本
/// 依照模型创建[ItemChoiceBuilder]
class ChoiceItem extends BaseChoiceItem {
  double imgWidth;
  double imgHeight;
  Selected<String> image;
  Selected<String> text;
  Selected<TextStyle> textStyle;

  ChoiceItem(
      {this.imgWidth,
      this.imgHeight,
      this.image,
      this.text,
      this.textStyle,
      bool selected = false})
      : assert(imgWidth != null && imgWidth > 0),
        assert(imgHeight != null && imgHeight > 0),
        super(selected);
}

typedef CheckTest<T> = bool Function(T data, int index);


abstract class DialogItemBuilder<W> extends StatelessWidget {
  final W data;
  final GestureTapCallback onTap;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final double height;
  final BorderRadius borderRadius;

  DialogItemBuilder({
    @required this.data,
    this.onTap,
    this.alignment,
    this.height,
    this.padding,
    this.borderRadius,
  });
}

/// 文本条目
class ItemTextBuilder extends DialogItemBuilder<TextItem> {
  ItemTextBuilder({
    @required TextItem data,
    GestureTapCallback onTap,
    AlignmentGeometry alignment,
    EdgeInsetsGeometry padding,
    double height,
    BorderRadius borderRadius,
  }) : super(
            data: data,
            onTap: onTap,
            alignment: alignment,
            padding: padding,
            height: height,
            borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? Container(
            alignment: alignment,
            height: height,
            padding: padding,
            child: Text(
              data.text,
              style: data.textStyle,
            ),
          )
        : ActionButton(
            customBorder: borderRadius != null
                ? RoundedRectangleBorder(borderRadius: borderRadius)
                : null,
            innerPadding: padding,
            height: height,
            text: data.text,
            textStyle: data.textStyle,
            alignment: alignment ?? Alignment.center,
            onTap: onTap,
          );
  }
}

/// 选择条目
class ItemChoiceBuilder extends DialogItemBuilder<ChoiceItem> {

  ItemChoiceBuilder({
    @required ChoiceItem data,
    GestureTapCallback onTap,
    AlignmentGeometry alignment,
    double height,
    EdgeInsetsGeometry padding,
    BorderRadius borderRadius,
  }) : super(
      data: data,
      onTap: onTap,
      alignment: alignment,
      padding: padding,
      height: height,
      borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) {
    Widget child;
    String path = Selected.getSelected(data.image, data.selected);
    String text = Selected.getSelected(data.text, data.selected);
    TextStyle textStyle = Selected.getSelected(data.textStyle, data.selected);
    if(hasImage && hasText){
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: textStyle,),
          Image.asset(path, width: data.imgWidth, height: data.imgHeight,),
        ],
      );
    }else if(hasImage){
      child = Image.asset(path, width: data.imgWidth, height: data.imgHeight,);
    }else {
      child = Text(text ?? "", style: textStyle,);
    }

    return ActionButton(
      customBorder: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius)
          : null,
      innerPadding: padding,
      height: height,
      alignment: alignment ?? Alignment.center,
      onTap: onTap,
      child: child,
    );
  }

  bool get hasImage => data.image != null;

  bool get hasText => data.text != null;
}
