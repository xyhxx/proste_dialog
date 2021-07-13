import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proste_dialog/src/dialog_base.dart';

/// 显示自定义的dialog
class ProsteCustomDialog extends StatefulWidget {
  ProsteCustomDialog({
    Key? key,
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    this.dialogRadius = 5,
    this.header,
    this.title,
    required this.content,
    this.titlePadding = const EdgeInsets.only(top: 15, left: 15, right: 15),
    this.contentPadding = const EdgeInsets.all(10),
    this.confirmButtonText = const Text('Confirm'),
    this.cancelButtonText = const Text('Cancel'),
    this.showConfirmButton = true,
    this.showCancelButton = true,
    this.buttonRadius = 5,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.onConfirm,
    this.onCancel,
    this.duration,
    this.backgroundColor = Colors.white,
    this.elevation = 0,
    this.shadowColor,
    this.btnsInARow = true,
    this.btnPadding,
    this.confirmButtonMargin,
  }) : super(key: key);

  /// dialog与屏幕之间的间距
  final EdgeInsets insetPadding;

  /// 对话框的圆角
  final double dialogRadius;

  /// 头部组件
  final Widget? header;

  /// 标题组件
  final Text? title;

  /// 标题的padding
  final EdgeInsets titlePadding;

  /// 描述文字
  final Text content;

  /// 描述的间距
  final EdgeInsets contentPadding;

  /// 确认按钮文字
  final Text confirmButtonText;

  /// 取消按钮文字
  final Text cancelButtonText;

  /// 是否展示确认按钮
  final bool showConfirmButton;

  /// 是否展示取消按钮
  final bool showCancelButton;

  /// 按钮边框圆角
  final double buttonRadius;

  /// 确认按钮背景色
  final Color? confirmButtonColor;

  /// 取消按钮背景色
  final Color? cancelButtonColor;

  /// 确认按钮点击事件
  final void Function()? onConfirm;

  /// 取消按钮点击事件
  final void Function()? onCancel;

  /// 显示时间
  final Duration? duration;

  /// dialog背景色
  final Color? backgroundColor;

  /// 内容框的elevation属性
  final double? elevation;

  /// 阴影颜色
  final Color? shadowColor;

  /// 按钮是否放在同一行
  final bool btnsInARow;

  /// 按钮的padding
  final EdgeInsets? btnPadding;

  /// 不是同一行是确认按钮的margin
  final EdgeInsets? confirmButtonMargin;

  @override
  _ProsteCustomDailogState createState() => _ProsteCustomDailogState();
}

class _ProsteCustomDailogState extends State<ProsteCustomDialog> {
  Timer? _time;

  @override
  void initState() {
    if (widget.duration != null) {
      _time = Timer(widget.duration!, () => Navigator.pop(context));
    }
    super.initState();
  }

  @override
  void dispose() {
    _time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProsteBaseDialog(
      insetPadding: widget.insetPadding,
      dialogRadius: widget.dialogRadius,
      widget: widget.header,
      title: widget.title,
      content: widget.content,
      titlePadding: widget.titlePadding,
      contentPadding: widget.contentPadding,
      confirmButtonText: widget.confirmButtonText,
      cancelButtonText: widget.cancelButtonText,
      showConfirmButton:
          widget.duration == null ? widget.showConfirmButton : false,
      showCancelButton:
          widget.duration == null ? widget.showCancelButton : false,
      buttonRadius: widget.buttonRadius,
      confirmButtonColor: widget.confirmButtonColor,
      cancelButtonColor: widget.cancelButtonColor,
      onConfirm: widget.onConfirm,
      onCancel: widget.onCancel,
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      shadowColor: widget.shadowColor,
      btnInARow: widget.btnsInARow,
      btnPadding: widget.btnPadding,
      confirmButtonMargin: widget.confirmButtonMargin,
    );
  }
}
