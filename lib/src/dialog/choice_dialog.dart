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
    super.key,
    super.title,
    super.titleText,
    super.titlePadding,
    super.titleTextStyle,
    super.titleAlign = TextAlign.center,
    super.hasTitleDivider = false,
    super.titleDivider,
    required super.datas,
    super.itemPadding = DialogStyle.listItemHorizontal,
    super.itemHeight = DialogStyle.itemHeight,
    super.itemAlignment = Alignment.center,
    super.itemDividerBuilder,
    super.itemBuilder,
    super.contentPadding = EdgeInsets.zero,
    super.positiveText,
    super.positiveTextStyle,
    super.positiveTap,
    super.hasPositive = true,
    super.negativeText,
    super.negativeTextStyle,
    super.negativeTap,
    super.hasNegative = true,
    super.actionHeight,
    super.actionPadding,
    super.dialogMargin,
    super.dialogPadding,
    super.backgroundColor,
    super.topRadius = 20.0,
    super.bottomRadius = 20.0,
    super.elevation,
    super.dividerColor = DHColors.color_000000_15,
    super.actionDividerBuilder,
    super.dialogAlignment = Alignment.bottomCenter,
    super.dialogWidth,
    super.dialogMinHeight,
    super.dialogMaxHeight,
    this.multiChose = false,
  });

  @override
  Widget buildItem(
      BuildContext context, int index, BorderRadius? borderRadius) {
    if (multiChose) {
      return Builder(
          builder: (context) => _buildItem(context, index, borderRadius));
    } else {
      return _buildItem(context, index, borderRadius);
    }
  }

  Widget _buildItem(
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
