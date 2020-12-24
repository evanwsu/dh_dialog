import 'package:flutter/widgets.dart';

import '../item_builder.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import 'list_dialog.dart';

///@author Evan
///@since 2020/12/15
///@describe:

/// 选择对话框
/// [itemHeight] 设置选择条目高度, 通常设置高度后, 不用设置垂直方向padding
/// [itemPadding] 条目填充边距, 在[itemHeight]的限制下作用
///
///
class DHChoiceDialog extends DHListDialog {
  /// 是否多选
  final bool multiChose;

  DHChoiceDialog(
      {Key key,
      Widget title,
      String titleText,
      EdgeInsetsGeometry titlePadding,
      TextStyle titleTextStyle,
      TextAlign titleAlign = TextAlign.center,
      @required List<DialogListItem> datas,
      EdgeInsetsGeometry itemPadding = DialogStyle.listItemHorizontal,
      double itemHeight = DialogStyle.itemHeight,
      Alignment itemAlignment = Alignment.center,
      IndexedWidgetBuilder itemDividerBuilder,
      ListItemBuilder itemBuilder,
      String positiveText,
      TextStyle positiveTextStyle,
      GestureTapCallback positiveTap,
      bool hasPositive = true,
      String negativeText,
      TextStyle negativeTextStyle,
      GestureTapCallback negativeTap,
      bool hasNegative = true,
      double actionHeight,
      EdgeInsetsGeometry dialogMargin,
      Color backgroundColor,
      double circleRadius = 20.0,
      double elevation,
      Color dividerColor = DHColors.color_000000_15,
      DividerBuilder actionDividerBuilder,
      AlignmentGeometry dialogAlignment = Alignment.bottomCenter,
      this.multiChose = false})
      : super(
            key: key,
            title: title,
            titleText: titleText,
            titlePadding: titlePadding,
            titleTextStyle: titleTextStyle,
            titleAlign: titleAlign,
            datas: datas,
            itemHeight: itemHeight,
            itemPadding: itemPadding,
            itemAlignment: itemAlignment,
            itemDividerBuilder: itemDividerBuilder,
            itemBuilder: itemBuilder,
            positiveText: positiveText,
            positiveTextStyle: positiveTextStyle,
            positiveTap: positiveTap,
            hasPositive: hasPositive,
            negativeText: negativeText,
            negativeTextStyle: negativeTextStyle,
            negativeTap: negativeTap,
            hasNegative: hasNegative,
            actionHeight: actionHeight,
            dialogMargin: dialogMargin,
            backgroundColor: backgroundColor,
            circleRadius: circleRadius,
            elevation: elevation,
            dividerColor: dividerColor,
            actionDividerBuilder: actionDividerBuilder,
            dialogAlignment: dialogAlignment);

  @override
  Widget buildItem(BuildContext context, int index, BorderRadius borderRadius) {
    final DialogListItem item = datas[index];
    // 校验是否BaseChoiceItem子类
    assert(item.widget is BaseChoiceItem,
        "DialogListItem.widget must be a subclass of BaseChoiceItem");

    GestureTapCallback onTap = () {
      if (multiChose) {
        item.widget.selected = !item.widget.selected;
      } else {
        if (item.widget.selected) return;
        datas.forEach((data) => data.widget.selected = data == item);
      }
      (context as Element).markNeedsBuild();
    };

    Widget child = itemBuilder?.call(
      context,
      item,
      borderRadius: borderRadius,
      padding: itemPadding,
      height: itemHeight,
      alignment: itemAlignment,
      onTap: onTap,
    );

    if (child == null && item.widget is ChoiceItem) {
      child = ItemChoiceBuilder(
        data: item.widget,
        alignment: itemAlignment,
        height: itemHeight,
        padding: itemPadding,
        borderRadius: borderRadius,
        onTap: onTap,
      );
    }
    return child;
  }
}
