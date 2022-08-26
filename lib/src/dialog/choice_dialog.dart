import 'package:flutter/widgets.dart';

import '../item_builder.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import 'list_dialog.dart';

///@author Evan
///@since 2020/12/15
///@describe:
/// 选择对话框
/// 使用[showDHDialog]显示对话框
/// [datas]元素[DialogListItem.widget]必须是BaseChoiceItem的子类
/// [itemHeight] 设置选择条目高度, 通常设置高度后, 不用设置垂直方向padding
/// [itemPadding] 条目填充边距, 在[itemHeight]的限制下作用
/// [itemAlignment] 条目对齐方式，默认居中
/// [itemDividerBuilder] 条目分割线构造器
/// [itemBuilder] 条目布局构造器
///
///
class DHChoiceDialog<W extends BaseChoiceItem, D> extends DHListDialog<W, D> {
  /// 是否多选
  final bool multiChose;

  DHChoiceDialog({
    Key? key,
    Widget? title,
    String? titleText,
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleTextStyle,
    TextAlign titleAlign = TextAlign.center,
    bool hasTitleDivider = false,
    Widget? titleDivider,
    required List<DialogListItem<W, D>> datas,
    EdgeInsetsGeometry? itemPadding = DialogStyle.listItemHorizontal,
    double itemHeight = DialogStyle.itemHeight,
    Alignment itemAlignment = Alignment.center,
    IndexedWidgetBuilder? itemDividerBuilder,
    ListItemBuilder<W>? itemBuilder,
    EdgeInsetsGeometry? contentPadding = EdgeInsets.zero,
    String? positiveText,
    TextStyle? positiveTextStyle,
    GestureTapCallback? positiveTap,
    bool hasPositive = true,
    String? negativeText,
    TextStyle? negativeTextStyle,
    GestureTapCallback? negativeTap,
    bool hasNegative = true,
    double? actionHeight,
    EdgeInsets? dialogMargin,
    EdgeInsets? dialogPadding,
    Color? backgroundColor,
    double topRadius = 20.0,
    double bottomRadius = 20.0,
    double? elevation,
    Color? dividerColor = DHColors.color_000000_15,
    DividerBuilder? actionDividerBuilder,
    AlignmentGeometry dialogAlignment = Alignment.bottomCenter,
    double? dialogWidth,
    this.multiChose = false,
  }) : super(
          key: key,
          title: title,
          titleText: titleText,
          titlePadding: titlePadding,
          titleTextStyle: titleTextStyle,
          titleAlign: titleAlign,
          hasTitleDivider: hasTitleDivider,
          titleDivider: titleDivider,
          datas: datas,
          itemHeight: itemHeight,
          itemPadding: itemPadding,
          itemAlignment: itemAlignment,
          itemDividerBuilder: itemDividerBuilder,
          itemBuilder: itemBuilder,
          contentPadding: contentPadding,
          positiveText: positiveText,
          positiveTextStyle: positiveTextStyle,
          positiveTap: positiveTap,
          hasPositive: hasPositive,
          negativeText: negativeText,
          negativeTextStyle: negativeTextStyle,
          negativeTap: negativeTap,
          hasNegative: hasNegative,
          actionHeight: actionHeight,
          backgroundColor: backgroundColor,
          topRadius: topRadius,
          bottomRadius: bottomRadius,
          elevation: elevation,
          dividerColor: dividerColor,
          actionDividerBuilder: actionDividerBuilder,
          dialogAlignment: dialogAlignment,
          dialogMargin: dialogMargin,
          dialogPadding: dialogPadding,
          dialogWidth: dialogWidth,
        );

  @override
  Widget buildItem(
      BuildContext context, int index, BorderRadius? borderRadius) {
    final DialogListItem<W, D> item = datas[index];
    W widget = item.widget;

    GestureTapCallback onTap = () {
      if (multiChose) {
        widget.selected = !widget.selected;
      } else {
        if (widget.selected) return;
        datas.forEach((data) => data.widget.selected = data == item);
      }
      (context as Element).markNeedsBuild();
    };

    Widget? child = itemBuilder?.call(
      context,
      widget,
      index,
      borderRadius: borderRadius,
      padding: itemPadding,
      height: itemHeight,
      alignment: itemAlignment,
      onTap: onTap,
    );

    if (child == null && widget is ChoiceItem) {
      child = ItemChoiceBuilder(
        data: widget,
        alignment: itemAlignment,
        height: itemHeight,
        padding: itemPadding,
        borderRadius: borderRadius,
        onTap: onTap,
      );
    }
    assert(child != null,
        'List item build failed, you must set itemBuilder or datas element widget is ChoiceItem');
    return child!;
  }
}
