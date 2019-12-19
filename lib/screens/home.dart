import 'package:flutter/material.dart';
import 'package:ringl8/screens/drawer/bottom_drawer.dart';
import 'package:ringl8/screens/drawer/drawers.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        TopDrawer(),
        Drawers(),
//        BottomDrawer(),
      ],
    );
  }
}
