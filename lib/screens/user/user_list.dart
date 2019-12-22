import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
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
    final currentUser = Provider.of<User>(context);
    return StreamBuilder<List<User>>(
      stream: UserService(uid: currentUser.uid).users,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        List<User> _currentUsers = snapshot.data;
        return ListView.builder(
          itemCount: _currentUsers.length,
          itemBuilder: (context, index) {
            return UserTile(user: _currentUsers[index]);
          },
        );
      },
    );
  }
}
