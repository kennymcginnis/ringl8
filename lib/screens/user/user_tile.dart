import 'package:flutter/material.dart';
import 'package:ringl8/models/user.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
//            backgroundImage: AssetImage('assets/running-blue-transparent.png'),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.email),
        ),
      ),
    );
  }
}
