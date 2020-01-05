import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/routes/application.dart';

class MembershipTile extends StatelessWidget {
  final Group group;

  MembershipTile(this.group);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
          onTap: () => Application.router.navigateTo(
            context,
            '/group',
            transition: TransitionType.fadeIn,
          ),
          leading: CircleAvatar(
            child: Text(group.name.substring(0, 2).toUpperCase()),
          ),
          title: Text(group.name),
        ),
      ),
    );
  }
}
