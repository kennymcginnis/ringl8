import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes.dart';
import 'package:ringl8/screens/auth_wrapper.dart';
import 'package:ringl8/services/auth.dart';

void main() => Routes();

//runApp(MyApp());
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamProvider<User>.value(
//      value: AuthService().user,
//      child: MaterialApp(
//        title: 'Inner Drawer',
//        theme: ThemeData(
//          primarySwatch: Colors.blueGrey,
//          backgroundColor: Colors.white,
//        ),
//        home: AuthWrapper(),
//      ),
//    );
//  }
//}
