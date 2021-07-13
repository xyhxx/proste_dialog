import 'dart:async';

import 'package:flutter/material.dart';

/// 关闭按钮字体Icon
const IconData closeIcon = IconData(0xe67a, fontFamily: 'AliIcon', fontPackage: 'proste_dialog');

/// 宣传图片弹窗
class ProsteAdvertiseDialog extends StatefulWidget {
  ProsteAdvertiseDialog({
    Key? key,
    this.factor = .9,
    required this.image,
    this.closeIconColor = Colors.white70,
    this.onImagePressed,
    this.onClosePressed,
    this.showCloseIcon = false,
    this.imageRadius = BorderRadius.zero,
    this.closeBtnSize = 32,
    this.duration,
    this.btnInARow = true,
    this.btnPadding,
  })  : assert(factor > 0),
        assert(factor <= 1),
        super(key: key);

  /// 图片所占屏幕宽度 值在0~1之间
  final double factor;

  /// 显示的图片组件
  final ImageProvider image;

  /// 关闭按钮组件颜色
  final Color closeIconColor;

  /// 图片点击事件
  final void Function()? onImagePressed;

  /// 点击关闭事件
  final void Function()? onClosePressed;

  /// 是否显示关闭按钮
  final bool showCloseIcon;

  /// 图片的边框弧度
  final BorderRadius imageRadius;

  /// 关闭按钮大小
  final double closeBtnSize;

  /// 延时关闭
  final Duration? duration;

  /// 按钮是否放在同一行
  final bool btnInARow;

  /// 按钮的padding
  final EdgeInsets? btnPadding;

  @override
  _ProsteAdvertiseDialogState createState() => _ProsteAdvertiseDialogState();
}

class _ProsteAdvertiseDialogState extends State<ProsteAdvertiseDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.duration != null) {
      _timer = Timer(widget.duration!, () {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _imgWidget(BuildContext context, bool isPortrait) {
    return GestureDetector(
      onTap: widget.onImagePressed ?? () => Navigator.pop(context),
      child: ClipRRect(
        borderRadius: widget.imageRadius,
        child: Image(
          image: widget.image,
          fit: isPortrait ? BoxFit.fitWidth : BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _closeBtn(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: widget.closeBtnSize,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(
        closeIcon,
        color: widget.closeIconColor,
      ),
      onPressed: widget.onClosePressed ?? () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: OrientationBuilder(
        builder: (context, orientation) {
          bool isPortrait = orientation == Orientation.portrait;
          return isPortrait
              ? FractionallySizedBox(
                  widthFactor: widget.factor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _imgWidget(context, isPortrait),
                      if (widget.showCloseIcon && widget.duration == null) ...[
                        SizedBox(height: 15),
                        _closeBtn(context),
                      ],
                    ],
                  ),
                )
              : FractionallySizedBox(
                  heightFactor: widget.factor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            _imgWidget(context, isPortrait),
                            if (widget.showCloseIcon && widget.duration == null)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: _closeBtn(context),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
