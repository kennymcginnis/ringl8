import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/user/settings.dart';
import 'package:ringl8/screens/user/user_list.dart';
import 'package:ringl8/services/auth.dart';
import 'package:ringl8/services/user.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

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
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
