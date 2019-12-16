import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/users/user_list.dart';
import 'package:ringl8/services/auth.dart';
import 'package:ringl8/services/user.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
        value: UserService().users,
        child: Scaffold(
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
          body: UserList(),
        ));
  }
}
