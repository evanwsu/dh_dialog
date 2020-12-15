import 'package:flutter/widgets.dart';

import 'action_button.dart';

///@author Evan
///@since 2020/12/15
///@describe:

class TextItem {
  final String text;
  final TextStyle textStyle;

  TextItem({
    @required this.text,
    this.textStyle,
  });
}

abstract class DialogItemBuilder<W, D> extends StatelessWidget {
  final W widget;
  final GestureTapCallback onTap;

  DialogItemBuilder({@required this.widget, this.onTap});
}

class ItemTextBuilder extends DialogItemBuilder {
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  ItemTextBuilder({
    @required TextItem widget,
    GestureTapCallback onTap,
    this.alignment,
    this.padding,
    this.borderRadius,
  }) : super(widget: widget, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? Container(
            alignment: alignment,
            padding: padding,
            child: Text(
              widget.text,
              style: widget.textStyle,
            ),
          )
        : ActionButton(
            customBorder: borderRadius != null
                ? RoundedRectangleBorder(borderRadius: borderRadius)
                : null,
            innerPadding: padding,
            text: widget.text,
            textStyle: widget.textStyle,
            alignment: alignment ?? Alignment.center,
            onTap: onTap,
          );
  }
}
