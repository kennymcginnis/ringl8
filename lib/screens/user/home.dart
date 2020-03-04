import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/group_icon.dart';
import 'package:ringl8/helpers/flushbar.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user_group.dart';
import 'package:ringl8/models/wrapper.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/routes/application.dart';
import 'package:ringl8/services/group.dart';

class UsersHome extends StatelessWidget {
  final application = sl.get<AppState>();

  final List<Choice> choices = <Choice>[
    Choice(title: '- My Groups -', icon: Icon(Icons.group)),
    Choice(title: '- Invitations -', icon: Icon(Icons.person_add)),
  ];

  @override
  Widget build(BuildContext context) {
    List<UserGroup> _currentGroups = Provider.of<UserGroup>(context) ?? [];
    if (_currentGroups.isEmpty) _currentGroups = [UserGroup()];
    List<Group> _currentInvites = Provider.of<Invitations>(context)?.invitations ?? [];
    if (_currentInvites.isEmpty) _currentInvites = [Group()];
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
                itemBuilder: (context, index) => _buildMembershipTile(
                  context,
                  _currentGroups[index],
                ),
              ),
              ListView.builder(
                itemCount: _currentInvites.length,
                itemBuilder: (context, index) => _buildInvitationsTile(
                  context,
                  _currentInvites[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipTile(BuildContext context, Group group) {
    if (group.uid == null)
      return Center(
        child: Text(
          'Not a member of any groups.',
          style: TextStyle(fontSize: 20),
        ),
      );
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: ListTile(
            onTap: () {
              application.currentGroup = group;
              application.currentGroupUID = group.uid;
              return Application.router.navigateTo(
                context,
                '/defaults',
                transition: TransitionType.fadeIn,
              );
            },
            leading: GroupIcon(group, size: Size.small),
            title: Text(group.name),
            trailing: IconButton(
              icon: Icon(
                FontAwesomeIcons.doorOpen,
                size: 20,
                color: Theme.of(context).primaryColorLight,
              ),
              onPressed: () async {
                try {
                  List<String> removed = group.members
                      .where((member) => member != application.currentUserUID)
                      .toList();
                  await GroupService().updateGroupMembers(removed);
                  FlushbarHelper(context, Status.success, 'You have left ${group.name}.').show();
                } catch (e) {
                  FlushbarHelper(context, Status.error, e.toString()).show();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvitationsTile(BuildContext context, Group group) {
    if (group.uid == null)
      return Center(
        child: Text(
          'No pending group invitations.',
          style: TextStyle(fontSize: 20),
        ),
      );
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {},
            leading: GroupIcon(group, size: Size.small),
            title: Text(group.name),
          ),
        ),
      ),
    );
  }
}
