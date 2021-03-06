English | <a href="https://github.com/xyhxx/proste_dialog/blob/master/doc/cn.md" >中文</a>

# Introduce

The function and design idea of package refer to <a href="https://github.com/xsahil03x/giffy_dialog">giffy_dialog</a>,at giffy_ Dialog provides higher degree of freedom and stronger scalability,you can use various types of prompts preset in the package, or you can set the widget you want to display.Compared to giffy_ Dialog, customization is not limited to images, you can also pass in any widget or custom animation.proste_dialogneeds ShowDialog to display. If you want to use animation effects in the display process, you can refer to the <a href="https://github.com/JackJonson/flutter_animated_dialog">flutter_animated_dialog</a>.

# Usage

__Note that if you pass in duration, the dialog will disappear automatically after the specified time. Even if your showconfirmbutton, showcancelbutton and showcloseicon are all true, the button will not be displayed__

1. `ProsteDialog` dialog of preset animation prompt in package

| parameter | parameterType | default |
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

<img src="https://raw.githubusercontent.com/xyhxx/program_preview/master/proste_dialog/preinstall.png"/>

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

2. `ProsteCustomDialog` customize dialog for header

| parameter | parameterType | default |
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

<img src="https://raw.githubusercontent.com/xyhxx/program_preview/master/proste_dialog/custom2.png" />

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

3. `ProsteAdvertiseDialog` Dialog box with pictures only

| parameter | parameterType | default |
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

<img src="https://raw.githubusercontent.com/xyhxx/program_preview/master/proste_dialog/ProsteAdvertiseDialog.png"/>

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
If there is any problem or bug, please submit it to <a href="https://github.com/xyhxx/proste_dialog/issues">issue</a>, I will deal with it as soon as I see it, thanks!