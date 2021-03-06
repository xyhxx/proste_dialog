import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proste_dialog/src/dialog_base.dart';

enum DialogTipType {
  success,
  warn,
  error,
}

class ProsteDialog extends StatefulWidget {
  ProsteDialog({
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    this.dialogRadius = 5,
    this.type = DialogTipType.success,
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
  });

  /// dialog与屏幕之间的间距
  final EdgeInsets insetPadding;

  /// 对话框的圆角
  final double dialogRadius;

  /// 显示的提示图片
  final DialogTipType type;

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
  @override
  _ProsteDialogState createState() => _ProsteDialogState();
}

class _ProsteDialogState extends State<ProsteDialog>
    with TickerProviderStateMixin {
  /// 演示关闭控制器
  Timer? _time;

  /// 动画控制器
  late AnimationController _controller;
  late AnimationController _scaleController;
  Animation? _rotationAnimation;
  Animation? _scaleAnimation;
  Animation? _translationAnimation;

  /// 图片地址Map
  Map<DialogTipType, Map> _pathMap = {
    DialogTipType.success: {
      'img': 'lib/src/assets/images/success.png',
      'background': 'lib/src/assets/images/success_background.png',
    },
    DialogTipType.warn: {
      'img': 'lib/src/assets/images/warn.png',
      'background': 'lib/src/assets/images/warn_background.png',
    },
    DialogTipType.error: {
      'img': 'lib/src/assets/images/error.png',
      'background': 'lib/src/assets/images/error_background.png',
    },
  };

  @override
  void initState() {
    super.initState();
    if (widget.duration != null) {
      _time = Timer(widget.duration!, () => Navigator.pop(context));
    }
    // 判断动画类型
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..forward();
    switch (widget.type) {
      case DialogTipType.success:
        _scaleAnimation =
            Tween<double>(begin: .3, end: 1).animate(_scaleController);
        _rotationAnimation = Tween<double>(begin: pi / 2, end: 0)
            .chain(CurveTween(curve: Curves.bounceOut))
            .animate(_controller);
        break;
      case DialogTipType.warn:
        _scaleAnimation =
            Tween<double>(begin: 1.5, end: 1).animate(_scaleController);
        _translationAnimation = Tween<double>(begin: -25, end: 0)
            .chain(CurveTween(curve: Curves.bounceOut))
            .animate(_controller);
        break;
      case DialogTipType.error:
        _scaleAnimation =
            Tween<double>(begin: .3, end: 1).animate(_scaleController);
        _rotationAnimation = Tween<double>(begin: pi / 2, end: 0)
            .chain(CurveTween(curve: Curves.elasticOut))
            .animate(_controller);
        break;
    }
  }

  @override
  void dispose() {
    _time?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// 背景图元素
  Widget _backgroundImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: FractionallySizedBox(
        widthFactor: .65,
        child: Image.asset(
          path,
          package: 'proste_dialog',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  /// 主提示图元素
  Widget _tipImageWidget(String path) {
    return FractionallySizedBox(
      widthFactor: .33,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          switch (widget.type) {
            case DialogTipType.success:
              return Transform.scale(
                scale: _scaleAnimation!.value,
                child: Transform(
                  transform: Matrix4.rotationY(_rotationAnimation!.value),
                  alignment: Alignment.center,
                  child: child,
                ),
              );
            case DialogTipType.warn:
              return Transform.scale(
                scale: _scaleAnimation!.value,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0, _translationAnimation!.value, 0),
                  child: child,
                ),
              );
            case DialogTipType.error:
              return Transform.scale(
                scale: _scaleAnimation!.value,
                child: Transform.rotate(
                  angle: _rotationAnimation!.value,
                  child: child,
                ),
              );
          }
        },
        child: Image.asset(
          path,
          package: 'proste_dialog',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  /// 提示图片
  Widget _tipImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _backgroundImage(_pathMap[widget.type]!['background']),
        _tipImageWidget(_pathMap[widget.type]!['img']),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProsteBaseDialog(
      insetPadding: widget.insetPadding,
      dialogRadius: widget.dialogRadius,
      widget: _tipImage(),
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
    );
  }
}
