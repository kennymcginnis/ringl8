import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:ringl8/screens/drawer/left_drawer.dart';
import 'package:ringl8/screens/drawer/right_drawer.dart';
import 'package:ringl8/screens/user/user_list.dart';

class Drawers extends StatefulWidget {
  Drawers({Key key}) : super(key: key);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> with SingleTickerProviderStateMixin {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  InnerDrawerDirection _direction = InnerDrawerDirection.start;
  double _offset = 0.85;
  double _dragUpdate = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      colorTransition: Colors.black54,
      leftAnimationType: InnerDrawerAnimation.static,
      leftOffset: _offset,
      onTapClose: true,
      rightAnimationType: InnerDrawerAnimation.linear,
      rightOffset: _offset,
      swipe: true,
      tapScaffoldEnabled: true,
      leftChild: LeftDrawer(_dragUpdate),
      rightChild: RightDrawer(_innerDrawerKey),
      scaffold: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorTween(
                begin: Colors.blueAccent,
                end: Colors.blueGrey[400].withRed(100),
              ).lerp(_dragUpdate),
              ColorTween(
                begin: Colors.black,
                end: Colors.black.withBlue(50),
              ).lerp(_dragUpdate),
            ],
          ),
        ),
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.grey[100]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: UserList(),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        UserList(),
//                      ],
//                    ),
//                  ],
//                ),
              ),
            ),
          ),
        ),
      ),
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        _direction = direction;
        setState(() => _dragUpdate = val);
      },
    );
  }
}
