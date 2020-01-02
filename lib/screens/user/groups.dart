import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/screens/group/create.dart';

import 'membership.dart';

class UsersGroups extends StatelessWidget {
  final List<Choice> choices = <Choice>[
    Choice(title: '- My Groups -', icon: Icon(Icons.group)),
    Choice(title: '- New Group -', icon: Icon(Icons.group_add)),
  ];

  @override
  Widget build(BuildContext context) {
    List<Group> _currentGroups = Provider.of<List<Group>>(context);
    if (_currentGroups == null) return Loading();
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          bottom: TabBar(
            isScrollable: true,
            tabs: choices
                .map<Widget>((Choice choice) => Tab(text: choice.title, icon: choice.icon))
                .toList(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: _currentGroups.length,
                itemBuilder: (context, index) => MembershipTile(_currentGroups[index]),
              ),
              CreateGroup(),
            ],
          ),
        ),
      ),
    );
  }
}
