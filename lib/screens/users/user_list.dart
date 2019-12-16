import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/users/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);
    if (users.length == 0) return Loading();
    return ListView.builder(
        itemCount: users.length, itemBuilder: (context, index) {
          return UserTile(user: users[index]);
    });
  }
}
