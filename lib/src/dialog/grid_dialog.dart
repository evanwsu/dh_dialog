import 'package:flutter/widgets.dart';

import '../../src/res/colors.dart';
import '../scroll_behavior.dart';
import '../utils.dart';
import 'alert_dialog.dart';
import 'list_dialog.dart';

///@author Evan
///@since 6/8/21
///@describe: 网格对话框

class DHGridDialog<W, D> extends DHAlertDialog {
  /// 列表数据结构
  final List<DialogListItem<W, D>> datas;

  /// item 水平填充
  final EdgeInsetsGeometry? itemPadding;

  /// item 水平对齐方式
  final AlignmentGeometry? itemAlignment;

  /// item构造器
  final ListItemBuilder<W> itemBuilder;

  /// item点击事件监听器
  final OnItemClickListener<D>? itemClickListener;

  /// 若主轴为垂直方向，从轴为水平方向，表示从轴行数
  /// 若主轴为水平方向，从轴为垂直方向，表示从轴列数
  final int crossAxisCount;

  /// 从轴间距
  final double crossAxisSpacing;

  /// 主轴间距
  final double mainAxisSpacing;

  /// 宽高比
  final double childAspectRatio;

  /// 主轴方向固定大小
  final double? mainAxisExtent;

  /// grid是否反向
  final bool reverse;

  DHGridDialog({
    Key? key,
    Widget? title,
    String? titleText,
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleTextStyle,
    TextAlign titleAlign = TextAlign.center,
    required this.datas,
    required this.itemBuilder,
    this.itemPadding = const EdgeInsets.all(16.0),
    this.itemAlignment = Alignment.center,
    this.itemClickListener,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
    this.reverse = false,
    EdgeInsetsGeometry? contentPadding =
        const EdgeInsets.symmetric(horizontal: 20.0),
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
    EdgeInsets? dialogPadding,
    AlignmentGeometry dialogAlignment = Alignment.bottomCenter,
  }) : super(
          key: key,
          title: title,
          titleText: titleText,
          titlePadding: titlePadding,
          titleTextStyle: titleTextStyle,
          titleAlign: titleAlign,
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
          dividerColor: dividerColor,
          actionDividerBuilder: actionDividerBuilder,
          backgroundColor: backgroundColor,
          topRadius: topRadius,
          bottomRadius: bottomRadius,
          elevation: elevation,
          dialogWidth: dialogWidth,
          dialogMargin: dialogMargin,
          dialogPadding: dialogPadding,
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
          child: GridView.builder(
            reverse: this.reverse,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: itemBuilder,
            itemCount: datas.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: this.crossAxisCount,
              mainAxisSpacing: this.mainAxisSpacing,
              crossAxisSpacing: this.crossAxisSpacing,
              childAspectRatio: this.childAspectRatio,
              mainAxisExtent: this.mainAxisExtent,
            ),
          ));
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
    Widget child = itemBuilder(
      context,
      item.widget,
      index,
      borderRadius: borderRadius,
      padding: itemPadding,
      alignment: itemAlignment,
      onTap: onTap,
    );
    return child;
  }

  bool get hasTitle => title != null || isNotEmpty(titleText);
}
