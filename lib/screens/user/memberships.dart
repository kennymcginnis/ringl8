import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/user.dart';

class Memberships extends StatefulWidget {
  @override
  _MembershipsState createState() => _MembershipsState();
}

class _MembershipsState extends State<Memberships> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return StreamBuilder<List<Group>>(
      stream: UserService(uid: currentUser.uid).groups(currentUser),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        List<Group> _currentGroups = snapshot.data;
        return ListView.builder(
          itemCount: _currentGroups.length,
          itemBuilder: (context, index) {
            return _buildGroupTile(_currentGroups[index]);
          },
        );
      },
    );
  }

  Widget _buildGroupTile(Group group) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: ,
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade800,
            child: Text(
              group.name.substring(0, 2).toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(group.name),
        ),
      ),
    );
  }
}
