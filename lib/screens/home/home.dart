import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/drawer/bottom_drawer.dart';
import 'package:ringl8/screens/drawer/drawers.dart';
import 'package:ringl8/services/user.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: UserService().users,
      child: Stack(
        children: <Widget>[
          Drawers(),
          BottomDrawer(),
        ],
      ),
    );
  }
}
