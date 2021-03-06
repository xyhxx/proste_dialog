# 介绍

package的功能和设计思路参考了<a href="https://github.com/xsahil03x/giffy_dialog">giffy_dialog</a>，在giffy_dialog的基础上提供了更高的自由度和更强的扩展性，您可以使用package中预设的各种类型提示，您也可以自己设置想要展示的元素。相比于giffy_dialog，自定义不仅限于图片，您也可以传入任何widget或者自定义的动画。proste_dialog需要通过showDialog来进行展示，如果您想要在展示过程中使用动画效果，可以参考<a href="https://github.com/JackJonson/flutter_animated_dialog">flutter_animated_dialog</a>。

# 使用

__注意，如果你传入了duration，dialog会在指定的时间后自动消失，即使你的showConfirmButton，showCancelButton, showCloseIcon 都为ture，按钮也是不会显示的__

1. `ProsteDialog` package内预设动画提示的dialog

| 参数 | 参数类型 | 默认值 |
| :-- | :---: | :---: |
| insetPadding | EdgeInsets | EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0) | 
| dialogRadius | double | 5 | 
| type | DialogTipType | DialogTipType.success | 
| title | Text | null | 
| content | Text(required) | null |
| titlePadding | EdgeInsets | EdgeInsets.only(top: 15, left: 15, right: 15) | 
| contentPadding | EdgeInsets | EdgeInsets.all(10) |
| confirmButtonText | Text | Text('Confirm') |
| cancelButtonText | Text | Text('Cancel') |
| showConfirmButton | bool | true |
| showCancelButton | bool | true |
| buttonRadius | double | 5 |
| confirmButtonColor | Color | null |
| cancelButtonColor | Color | null |
| onConfirm | void Funtion() | null |
| onCancel | void Funtion() | null |
| duration | Duration | null |

<img src="https://raw.githubusercontent.com/xyhxx/program_preview/master/proste_dialog/preinstall.png" align="right" />

``` dart 

showDialog(
  context: context,
  builder: (_) => ProsteDialog(
    type: _tipType,
    content: Text('this is package preinstall dialog'),
    insetPadding: EdgeInsets.all(15),
    dialogRadius: 10,
    title: Text('this is package preinstall dialog title'),
    titlePadding: EdgeInsets.only(top: 20),
    contentPadding: EdgeInsets.all(15),
    confirmButtonText: Text('next', style: TextStyle(color: Colors.white)),
    cancelButtonText: Text('back', style: TextStyle(color: Colors.green)),
    showConfirmButton: true,
    showCancelButton: true,
    confirmButtonColor: Colors.cyan,
    cancelButtonColor: Colors.black,
    onConfirm: () {
      print('preinstall confirm pressed');
      Navigator.pop(context);
    },
    onCancel: () {
      print('preinstall cancel pressed');
      Navigator.pop(context);
    },
  ),
);

```

2. `ProsteCustomDialog` 自定义头部的dialog

| 参数 | 参数类型 | 默认值 |
| :-- | :---: | :---: |
| insetPadding | EdgeInsets | EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0) | 
| dialogRadius | double | 5 | 
| header | Widget | null | 
| title | Text | null | 
| content | Text(required) | null |
| titlePadding | EdgeInsets | EdgeInsets.only(top: 15, left: 15, right: 15) | 
| contentPadding | EdgeInsets | EdgeInsets.all(10) |
| confirmButtonText | Text | Text('Confirm') |
| cancelButtonText | Text | Text('Cancel') |
| showConfirmButton | bool | true |
| showCancelButton | bool | true |
| buttonRadius | double | 5 |
| confirmButtonColor | Color | null |
| cancelButtonColor | Color | null |
| onConfirm | void Funtion() | null |
| onCancel | void Funtion() | null |
| duration | Duration | null |

<img align="right" src="https://raw.githubusercontent.com/xyhxx/program_preview/master/proste_dialog/custom2.png" />

``` dart

showDialog(
  context: context,
  builder: (_) => ProsteCustomDialog(
    insetPadding: EdgeInsets.zero,
    dialogRadius: 50,
    header: AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          height: _animation.value,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      },
    ),
    title: Text('this is diy title'),
    content: Text('this is diy dialog'),
    titlePadding: EdgeInsets.only(top: 20),
    contentPadding: EdgeInsets.only(top: 50),
    confirmButtonText: Text('next', style: TextStyle(color: Colors.white)),
    cancelButtonText: Text('back', style: TextStyle(color: Colors.green)),
    showConfirmButton: false,
    showCancelButton: true,
    confirmButtonColor: Colors.cyan,
    cancelButtonColor: Colors.black,
    onConfirm: () {
      print('diy confirm pressed');
      Navigator.pop(context);
    },
    onCancel: () {
      print('diy cancel pressed');
      Navigator.pop(context);
    },
  ),
);

```

`ProsteAdvertiseDialog` 纯图片展示的对话框

| 参数 | 参数类型 | 默认值 |
| :-- | :---: | :---: |
| factor | double (0< value <=1) | .9 |
| image | ImageProvider(required) | null |
| closeIconColor | Colors | Colors.white70 |
| onImagePressed | void Function() | null |
| onImagePressed | void Function() | null |
| showCloseIcon | bool | false |
| imageRadius | BorderRadius | BorderRadius.zero |
| closeBtnSize | double | 32 |
| duration | Duration | null |

<img src="https://raw.githubusercontent.com/xyhxx/program_preview/master/proste_dialog/ProsteAdvertiseDialog.png" align="right" />

``` dart

showDialog(
  context: context,
  builder: (_) => ProsteAdvertiseDialog(
    factor: .6,
    showCloseIcon: true,
    closeIconColor: Colors.pink,
    closeBtnSize: 20,
    image: NetworkImage(networkImg),
    imageRadius: BorderRadius.circular(10),
    onImagePressed: () {
      print('image pressed');
      Navigator.pop(context);
    },
    onClosePressed: () {
      print('close pressed');
      Navigator.pop(context);
    },
  ),
);

```

# Issue
如果有任何问题或者bug请提交到<a href="https://github.com/xyhxx/proste_dialog/issues">issue</a>，我会在看到后尽快处理，感谢！