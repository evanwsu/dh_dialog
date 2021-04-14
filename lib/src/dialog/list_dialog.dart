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
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  double? height,
  AlignmentGeometry? alignment,
  GestureTapCallback? onTap,
});

typedef OnItemClickListener<T> = void Function(
    T? data, int position, BuildContext context);

/// List对话框条目模型
class DialogListItem<W, D> {
  /// item控件模型
  final W widget;

  /// item数据模型
  final D? data;

  DialogListItem(
    this.widget, {
    this.data,
  });
}

/// List对话框
class DHListDialog<W, D> extends DHAlertDialog {
  /// 列表数据结构
  final List<DialogListItem<W, D>> datas;

  /// listItem 分割线，会覆盖[dividerColor]设置
  final IndexedWidgetBuilder? itemDividerBuilder;

  /// item 水平填充
  final EdgeInsetsGeometry? itemPadding;

  /// item 高度
  final double? itemHeight;

  /// item 水平对齐方式
  final AlignmentGeometry? itemAlignment;

  /// item构造器
  final ListItemBuilder<W>? itemBuilder;

  /// item点击事件监听器
  final OnItemClickListener<D>? itemClickListener;

  DHListDialog({
    Key? key,
    Widget? title,
    String? titleText,
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleTextStyle,
    TextAlign titleAlign = TextAlign.center,
    required this.datas,
    this.itemPadding = DialogStyle.listItemPadding,
    this.itemHeight,
    this.itemAlignment = Alignment.center,
    this.itemDividerBuilder,
    this.itemBuilder,
    this.itemClickListener,
    String? positiveText,
    TextStyle? positiveTextStyle,
    GestureTapCallback? positiveTap,
    bool hasPositive = true,
    String? negativeText,
    TextStyle? negativeTextStyle,
    GestureTapCallback? negativeTap,
    bool hasNegative = true,
    double? actionHeight,
    Color? dividerColor = DHColors.color_000000_15,
    DividerBuilder? actionDividerBuilder,
    Color? backgroundColor,
    double topRadius = 20.0,
    double bottomRadius = 20.0,
    double? elevation,
    double? dialogWidth,
    EdgeInsets? dialogMargin,
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
          topRadius: topRadius,
          bottomRadius: bottomRadius,
          elevation: elevation,
          dialogWidth: dialogWidth,
          dialogMargin: dialogMargin,
          dialogAlignment: dialogAlignment,
        );

  @override
  Widget? buildContent() {
    Widget? contentWidget;
    if (datas.isNotEmpty) {
      final top = Radius.circular(topRadius);
      final bottom = Radius.circular(bottomRadius);
      IndexedWidgetBuilder itemBuilder = (BuildContext context, int index) {
        // 无标题第一个item 设置上部分圆角
        BorderRadius? borderRadius;
        if (index == 0 && !hasTitle) {
          borderRadius = BorderRadius.vertical(top: top);
        } else if (index == datas.length - 1 &&
            (!hasNegative && !hasPositive)) {
          borderRadius = BorderRadius.vertical(bottom: bottom);
        }
        return buildItem(context, index, borderRadius);
      };

      contentWidget = ScrollConfiguration(
        behavior: NoneOverScrollBehavior(),
        child: itemDividerBuilder != null
            ? ListView.separated(
                shrinkWrap: true,
                itemBuilder: itemBuilder,
                separatorBuilder: itemDividerBuilder!,
                itemCount: datas.length,
              )
            : ListView.builder(
                shrinkWrap: true,
                itemBuilder: itemBuilder,
                itemCount: datas.length,
              ),
      );
    }
    return contentWidget;
  }

  Widget buildItem(
    BuildContext context,
    int index,
    BorderRadius? borderRadius,
  ) {
    final DialogListItem<W, D> item = datas[index];
    GestureTapCallback? onTap;
    if (itemClickListener != null) {
      onTap = () => itemClickListener?.call(item.data, index, context);
    }

    W widget = item.widget;
    Widget? child = itemBuilder?.call(
      context,
      widget,
      borderRadius: borderRadius,
      padding: itemPadding,
      height: itemHeight,
      alignment: itemAlignment,
      onTap: onTap,
    );

    if (child == null && widget is TextItem) {
      child = ItemTextBuilder(
        data: widget,
        alignment: itemAlignment,
        padding: itemPadding,
        height: itemHeight,
        borderRadius: borderRadius,
        onTap: onTap,
      );
    }
    assert(child != null, 'List item build failed, you must set itemBuilder or datas element widget is TextItem');
    return child!;
  }

  bool get hasTitle => title != null || isNotEmpty(titleText);
}
