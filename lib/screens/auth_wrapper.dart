import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/home/home.dart';
import 'package:ringl8/screens/login/login.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? LoginScreen() : Home();
  }
}
