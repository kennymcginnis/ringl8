import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomDrawer extends StatefulWidget {
  BottomDrawer({Key key}) : super(key: key);

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //systemNavigationBarColor: Colors.blue,
      statusBarColor: Colors.transparent,
      //statusBarBrightness: Brightness.dark,
    ));

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.black45,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2,
              0.0,
            ),
            child: _item(title: "One"),
          ),
          _toggle(),
        ],
      ),
    );
  }

  Widget _item({String title}) {
    //print(((_translateButton.value-66)/60).abs());
    double val = ((_translateButton.value - 56) / 60).abs();
    return Opacity(
      opacity: val > 0 ? 1 : 0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: val,
        onPressed: () {
          _animate();
        },
        tooltip: 'Apri',
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: Colors.green[300],
          ),
        ),
      ),
    );
  }

  Widget _toggle() {
    return new Container(
      child: FloatingActionButton(
        elevation: 1.5,
        backgroundColor: Colors.white,
        onPressed: _animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: _buttonColor.value,
          progress: _animateIcon,
        ),
      ),
    );
  }

  void _animate() {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }
}
