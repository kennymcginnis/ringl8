import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/home.dart';
import 'package:ringl8/screens/login/login.dart';

class AuthListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return currentUser == null ? Login() : Home();
  }
}
