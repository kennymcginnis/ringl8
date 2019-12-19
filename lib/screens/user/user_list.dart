import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/user/user_tile.dart';
import 'package:ringl8/services/user.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context) ?? [];
    return StreamProvider<List<User>>.value(
      value: UserService().users,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
      ),
    );
  }
}
