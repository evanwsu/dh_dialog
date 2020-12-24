import 'package:flutter/material.dart';

import '../item_builder.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../scroll_behavior.dart';
import '../utils.dart';
import 'alert_dialog.dart';
export 'alert_dialog.dart' show DividerBuilder, DividerType;

///@author Evan
///@since 2020/12/9
///@describe:

typedef ListItemBuilder<T> = Widget Function(
  BuildContext context,
  T item, {
  BorderRadius borderRadius,
  EdgeInsetsGeometry padding,
  double height,
  AlignmentGeometry alignment,
  GestureTapCallback onTap,
});

typedef OnItemClickListener<T> = void Function(
    T data, int position, BuildContext context);

/// List对话框条目模型
class DialogListItem<W, D> {
  final W widget;
  final D data;

  DialogListItem(
    this.widget, {
    this.data,
  });
}

/// List对话框
class DHListDialog extends DHAlertDialog {
  final List<DialogListItem> datas;

  /// listItem 分割线，会覆盖[dividerColor]设置
  final IndexedWidgetBuilder itemDividerBuilder;

  /// item 水平填充
  final EdgeInsetsGeometry itemPadding;

  /// item 高度
  final double itemHeight;

  /// item 水平对齐方式
  final AlignmentGeometry itemAlignment;

  final ListItemBuilder itemBuilder;

  final OnItemClickListener itemClickListener;

  DHListDialog({
    Key key,
    Widget title,
    String titleText,
    EdgeInsetsGeometry titlePadding,
    TextStyle titleTextStyle,
    TextAlign titleAlign = TextAlign.center,
    @required this.datas,
    this.itemPadding = DialogStyle.listItemPadding,
    this.itemHeight,
    this.itemAlignment = Alignment.center,
    this.itemDividerBuilder,
    this.itemBuilder,
    this.itemClickListener,
    String positiveText,
    TextStyle positiveTextStyle,
    GestureTapCallback positiveTap,
    bool hasPositive = true,
    String negativeText,
    TextStyle negativeTextStyle,
    GestureTapCallback negativeTap,
    bool hasNegative = true,
    double actionHeight,
    Color dividerColor = DHColors.color_000000_15,
    DividerBuilder actionDividerBuilder,
    Color backgroundColor,
    double circleRadius = 20.0,
    double elevation,
    EdgeInsetsGeometry dialogMargin,
    AlignmentGeometry dialogAlignment = Alignment.bottomCenter,
  })  : assert(datas != null),
        assert(dialogAlignment != null),
        assert(itemPadding != null || itemHeight != null),
        super(
          key: key,
          title: title,
          titleText: titleText,
          titlePadding: titlePadding,
          titleTextStyle: titleTextStyle,
          titleAlign: titleAlign,
          contentPadding: EdgeInsets.zero,
          positiveText: positiveText,
          positiveTextStyle: positiveTextStyle,
          positiveTap: positiveTap,
          hasPositive: hasPositive,
          negativeText: negativeText,
          negativeTextStyle: negativeTextStyle,
          negativeTap: negativeTap,
          hasNegative: hasNegative,
          actionHeight: actionHeight,
          dividerColor: dividerColor,
          actionDividerBuilder: actionDividerBuilder,
          backgroundColor: backgroundColor,
          circleRadius: circleRadius,
          elevation: elevation,
          dialogMargin: dialogMargin,
          dialogAlignment: dialogAlignment,
        );

  @override
  Widget buildContent() {
    Widget contentWidget;
    if (datas != null && datas.isNotEmpty) {
      final radius = Radius.circular(circleRadius);
      contentWidget = ScrollConfiguration(
          behavior: NoneOverScrollBehavior(),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // 无标题第一个item 设置上部分圆角
              BorderRadius borderRadius;
              if (index == 0 && !hasTitle) {
                borderRadius = BorderRadius.vertical(top: radius);
              } else if (index == datas.length - 1 &&
                  (!hasNegative && !hasPositive)) {
                borderRadius = BorderRadius.vertical(bottom: radius);
              }
              return buildItem(context, index, borderRadius);
            },
            separatorBuilder: itemDividerBuilder ??
                (BuildContext context, int index) => Container(
                      color: dividerColor,
                      height: 1,
                    ),
            itemCount: datas.length,
          ));
    }
    return contentWidget;
  }

  Widget buildItem(
    BuildContext context,
    int index,
    BorderRadius borderRadius,
  ) {
    final DialogListItem item = datas[index];
    GestureTapCallback onTap;
    if (itemClickListener != null) {
      onTap = () => itemClickListener.call(item.data, index, context);
    }

    Widget child = itemBuilder?.call(
      context,
      item,
      borderRadius: borderRadius,
      padding: itemPadding,
      height: itemHeight,
      alignment: itemAlignment,
      onTap: onTap,
    );

    if (child == null && item.widget is TextItem) {
      child = ItemTextBuilder(
        data: item.widget,
        alignment: itemAlignment,
        padding: itemPadding,
        height: itemHeight,
        borderRadius: borderRadius,
        onTap: onTap,
      );
    }
    return child;
  }

  bool get hasTitle => title != null || isNotEmpty(titleText);
}
