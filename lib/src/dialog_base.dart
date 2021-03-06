import 'package:flutter/material.dart';

/// 默认间距
const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

class ProsteBaseDialog extends StatelessWidget {
  ProsteBaseDialog({
    Key? key,
    this.insetPadding = _defaultInsetPadding,
    this.dialogRadius = 5,
    this.widget,
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
    this.backgroundColor = Colors.white,
    this.elevation = 0,
    this.shadowColor,
    this.btnInARow = true,
    this.btnPadding,
    this.confirmButtonMargin,
  }) : super(key: key);

  /// dialog与屏幕之间的间距
  final EdgeInsets insetPadding;

  /// 对话框的圆角
  final double dialogRadius;

  /// 显示图片
  final Widget? widget;

  /// 标题组件
  final Widget? title;

  /// 标题的padding
  final EdgeInsets titlePadding;

  /// 描述文字
  final Widget content;

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

  /// dialog背景色
  final Color? backgroundColor;

  /// card的elevation
  final double? elevation;

  /// 阴影颜色
  final Color? shadowColor;

  /// 按钮是否放在同一行
  final bool btnInARow;

  /// 按钮的padding
  final EdgeInsets? btnPadding;

  /// 不是同一行是确认按钮的margin
  final EdgeInsets? confirmButtonMargin;

  /// 标题和描述内容
  List<Widget> _infoWidget() {
    return [
      if (title != null)
        Padding(
          padding: titlePadding,
          child: title,
        ),
      Padding(
        padding: contentPadding,
        child: content,
      ),
    ];
  }

  /// 按钮组
  Widget _btnGroupWidget(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: btnInARow
          ? _bntGroupRow(context, themeColor)
          : _btnGroupColulmn(context, themeColor),
    );
  }

  /// 横向按钮组
  Widget _bntGroupRow(BuildContext context, Color color) {
    return Row(
      mainAxisAlignment: showConfirmButton && showCancelButton
          ? MainAxisAlignment.spaceEvenly
          : MainAxisAlignment.center,
      children: [
        if (showCancelButton)
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  cancelButtonColor ?? Colors.grey[400]),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
              ),
              padding: MaterialStateProperty.all(btnPadding),
            ),
            onPressed: onCancel ?? () => Navigator.pop(context),
            child: Container(child: cancelButtonText),
          ),
        if (showConfirmButton)
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(confirmButtonColor ?? color),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
              ),
              padding: MaterialStateProperty.all(btnPadding),
            ),
            onPressed: onConfirm ?? () => Navigator.pop(context),
            child: confirmButtonText,
          ),
      ],
    );
  }

  /// 竖向按钮组
  Widget _btnGroupColulmn(BuildContext context, Color color) {
    return Column(
      children: [
        if (showConfirmButton)
          Container(
            width: double.infinity,
            padding:
                confirmButtonMargin ?? EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(confirmButtonColor ?? color),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(buttonRadius),
                  ),
                ),
                padding: MaterialStateProperty.all(btnPadding),
              ),
              onPressed: onConfirm ?? () => Navigator.pop(context),
              child: confirmButtonText,
            ),
          ),
        if (showCancelButton)
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(btnPadding),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onCancel ?? () => Navigator.pop(context),
            child: cancelButtonText,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: insetPadding,
      child: OrientationBuilder(
        builder: (context, orientation) {
          bool isPortrait = orientation == Orientation.portrait;
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: isPortrait ? screenHeight * .8 : double.infinity,
              minWidth: double.infinity,
              maxWidth: double.infinity,
            ),
            child: Card(
              elevation: elevation,
              shadowColor: shadowColor,
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dialogRadius),
              ),
              child: isPortrait
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget != null)
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(dialogRadius),
                                topRight: Radius.circular(dialogRadius),
                              ),
                            ),
                            child: widget,
                          ),
                        ..._infoWidget(),
                        if (showConfirmButton || showCancelButton)
                          _btnGroupWidget(context),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget != null)
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(dialogRadius),
                                  bottomLeft: Radius.circular(dialogRadius),
                                ),
                              ),
                              child: widget,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ..._infoWidget(),
                              if (showConfirmButton || showCancelButton)
                                _btnGroupWidget(context),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
