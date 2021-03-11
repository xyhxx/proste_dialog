import 'package:flutter/material.dart';
import 'package:proste_dialog/proste_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome>
    with SingleTickerProviderStateMixin {
  DialogTipType _tipType = DialogTipType.success;
  late Animation _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
        Tween<double>(begin: 80, end: 200).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final String networkImg2 =
        'https://hbimg.huabanimg.com/f9012b3b86d3d90eb3b2fa8742261026c1eaa88b9c44b-CvNWds_fw658/format/webp';
    final String networkImg =
        'https://hbimg.huabanimg.com/06ef627a592f6c6b638720935b5e41782cafafe363c975-d13YKk_fw658/format/webp';
    final String assetImg = 'assets/images/demo_image.jpg';
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text('preinstall dialog type'),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<DialogTipType>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: DialogTipType.success,
                      title: Text('success'),
                      groupValue: _tipType,
                      onChanged: (val) {
                        setState(() {
                          _tipType = val!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<DialogTipType>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: DialogTipType.warn,
                      title: Text('warn'),
                      groupValue: _tipType,
                      onChanged: (val) {
                        setState(() {
                          _tipType = val!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<DialogTipType>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: DialogTipType.error,
                      title: Text('error'),
                      groupValue: _tipType,
                      onChanged: (val) {
                        setState(() {
                          _tipType = val!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
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
                      confirmButtonText:
                          Text('next', style: TextStyle(color: Colors.white)),
                      cancelButtonText:
                          Text('back', style: TextStyle(color: Colors.green)),
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
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                child: Text('auto close preinstall'),
              ),
              ElevatedButton(
                onPressed: () {
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
                      confirmButtonText:
                          Text('next', style: TextStyle(color: Colors.white)),
                      cancelButtonText:
                          Text('back', style: TextStyle(color: Colors.green)),
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
                },
                child: Text('preinstall dialog'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ProsteCustomDialog(
                      content: Text('this is auto close dialog'),
                      showCancelButton: true,
                      showConfirmButton: true,
                      header: Image.asset(assetImg),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('auto close dialog'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                  } else if (_animationController.isDismissed) {
                    _animationController.forward();
                  }
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
                      confirmButtonText:
                          Text('next', style: TextStyle(color: Colors.white)),
                      cancelButtonText:
                          Text('back', style: TextStyle(color: Colors.green)),
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
                },
                child: Text('widget custom dialog'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ProsteCustomDialog(
                      insetPadding: EdgeInsets.all(15),
                      dialogRadius: 15,
                      header: Image.asset(
                        assetImg,
                        fit: BoxFit.cover,
                      ),
                      title: Text('this is title'),
                      content: Text('this is content'),
                      titlePadding: EdgeInsets.only(top: 50),
                      contentPadding: EdgeInsets.symmetric(vertical: 80),
                      confirmButtonText:
                          Text('go', style: TextStyle(color: Colors.white)),
                      cancelButtonText:
                          Text('back', style: TextStyle(color: Colors.green)),
                      showConfirmButton: true,
                      showCancelButton: false,
                      buttonRadius: 80,
                      confirmButtonColor: Colors.pink,
                      cancelButtonColor: Colors.amber,
                      onConfirm: () {
                        print('confirm pressed');
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        print('cancel pressed');
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: Text('image custom dialog'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ProsteAdvertiseDialog(
                      factor: 1,
                      showCloseIcon: true,
                      closeIconColor: Colors.pink,
                      closeBtnSize: 20,
                      image: NetworkImage(networkImg2),
                      imageRadius: BorderRadius.circular(10),
                      onImagePressed: () {
                        print('image pressed');
                        Navigator.pop(context);
                      },
                      onClosePressed: () {
                        print('close pressed');
                        Navigator.pop(context);
                      },
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('auto close adv dialog'),
              ),
              ElevatedButton(
                onPressed: () {
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
                },
                child: Text('adv dialog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
