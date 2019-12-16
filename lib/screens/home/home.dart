import 'package:flutter/material.dart';
import 'package:ringl8/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('ringl8'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign out'),
              onPressed: () async {
                await _authService.signOut();
              })
        ],
      ),
    );
  }
}
