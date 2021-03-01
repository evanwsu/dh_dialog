import 'package:flutter/material.dart';

///@author Evan
///@since 2020-04-14
///@describe:

const slowDuration = Duration(milliseconds: 250);
const normalDuration = Duration(milliseconds: 150);

Future<T> showDHDialog<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  RouteTransitionsBuilder transitionBuilder,
  EntryAnimation entryAnimation = EntryAnimation.none,
  Duration transitionDuration,
  Color barrierColor,
  bool barrierDismissible = true,
  bool useSafeArea = true,
  bool useRootNavigator = true,
}) {
  return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        Widget dialog = Builder(builder: builder);
        if (useSafeArea) {
          dialog = SafeArea(child: dialog);
        }
        return dialog;
      },
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: "",
      useRootNavigator: useRootNavigator,
      transitionBuilder: transitionBuilder ??
          (context, animation, secondaryAnimation, child) =>
              _buildDialogTransition(context, animation, secondaryAnimation,
                  child, entryAnimation),
      transitionDuration:
          transitionDuration ?? ((entryAnimation == EntryAnimation.fade)
              ? normalDuration
              : slowDuration));
}

/// 根据动画类型构建动画控件
Widget _buildDialogTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    EntryAnimation entryAnimation) {
  Widget transition;
  Offset begin;
  switch (entryAnimation) {
    case EntryAnimation.fade:
      transition = FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child,
      );
      break;
    case EntryAnimation.slideLeft:
      begin = Offset(-1.0, .0);
      break;
    case EntryAnimation.slideTop:
      begin = Offset(.0, -1.0);
      break;
    case EntryAnimation.slideRight:
      begin = Offset(1.0, .0);
      break;
    case EntryAnimation.slideBottom:
      begin = Offset(.0, 1.0);
      break;
    case EntryAnimation.none:
    default:
      begin = Offset.zero;
      break;
  }

  if (transition == null) {
    transition = SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
  return transition;
}

/// 进入动画
/// fade 以渐现方式显示对话框
/// slide 以滑动动画方式显示对话框
enum EntryAnimation { slideLeft, slideTop, slideRight, slideBottom, fade, none }

/// 隐藏dialog
void dismissDHDialog<T extends Object>(BuildContext context, [T result]) =>
    Navigator.pop(context, result);
