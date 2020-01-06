import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/user_avatar.dart';
import 'package:ringl8/helpers/flushbar.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/services/group.dart';

class GroupMembers extends StatefulWidget {
  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  final _formKey = GlobalKey<FormState>();
  final application = sl.get<AppState>();

  String email = '';

  List<Choice> choices = <Choice>[
    Choice(title: '- Members -', icon: Icon(Icons.group)),
    Choice(title: '- Invited -', icon: Icon(Icons.group_add)),
  ];

  @override
  Widget build(BuildContext context) {
    List<User> _currentMembers = Provider.of<List<User>>(context) ?? [];
    List<String> _currentInvites = application.currentGroup.invites ?? [];
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(application.currentGroup.name),
          bottom: TabBar(
            isScrollable: true,
            tabs: choices
                .map<Widget>((choice) => Tab(text: choice.title, icon: choice.icon))
                .toList(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: TabBarView(
            children: [
              ListView.builder(
                key: PageStorageKey('MemberList'),
                shrinkWrap: true,
                itemCount: _currentMembers.length,
                itemBuilder: (_, index) => _buildMemberTile(_currentMembers[index]),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      key: PageStorageKey('InviteeList'),
                      shrinkWrap: true,
                      itemCount: _currentInvites.length,
                      itemBuilder: (_, index) => _buildInviteeTile(
                        context,
                        _currentInvites,
                        _currentInvites[index],
                      ),
                    ),
                  ),
                  _buildInviteMemberForm(context, _currentMembers, _currentInvites),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberTile(User user) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: UserAvatar(user: user, size: AvatarSize.small),
        title: Text(user.fullName()),
//        trailing: IconButton(
//          icon: Icon(
//            FontAwesomeIcons.userTimes,
//            size: 20,
//            color: theme.primaryColorLight,
//          ),
//          onPressed: () {
//            debugPrint('Remove member');
//          },
//        ),
      ),
    );
  }

  Widget _buildInviteeTile(BuildContext context, List<String> _currentInvites, String email) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        title: Text(email),
        trailing: IconButton(
          icon: Icon(
            FontAwesomeIcons.userTimes,
            size: 20,
            color: Theme.of(context).primaryColorLight,
          ),
          onPressed: () async {
            try {
              List<String> removed = _currentInvites.where((invitee) => invitee != email).toList();
              await GroupService().updateGroupInvites(removed);
              FlushbarHelper(context, Status.success, 'Invite removed for $email.').show();
            } catch (e) {
              FlushbarHelper(context, Status.error, e.toString()).show();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInviteMemberForm(
    BuildContext context,
    List<User> _currentMembers,
    List<String> _currentInvites,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputTextField(
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            labelText: 'Email',
            onChanged: (value) => setState(() => email = value),
            validator: Validators.validateEmail,
          ),
          ExtendedButton(
            text: 'Invite Group Member',
            onTap: () async {
              if (_formKey.currentState.validate()) {
                bool existing = _currentMembers.where((member) => member.email == email).isNotEmpty;
                if (existing) {
                  FlushbarHelper(context, Status.error, '$email is already a group member.').show();
                } else if (_currentInvites.contains(email)) {
                  FlushbarHelper(context, Status.error, '$email has already been invited.').show();
                } else {
                  try {
                    await GroupService().updateGroupInvites([
                      ..._currentInvites,
                      email,
                    ]);
                    setState(() => email = '');
                    FlushbarHelper(context, Status.success, 'Group invite sent to $email.').show();
                  } catch (e) {
                    FlushbarHelper(context, Status.error, e.toString()).show();
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
