import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/helpers/flushbar.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/application.dart';
import 'package:ringl8/services/group.dart';

class GroupMembers extends StatefulWidget {
  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  List<User> _currentMembers;
  List<String> _currentInvites;

  List<Choice> choices = <Choice>[
    Choice(title: '- Members -', icon: Icon(Icons.group)),
    Choice(title: '- Invited -', icon: Icon(Icons.group_add)),
  ];

  @override
  Widget build(BuildContext context) {
    _currentMembers = Provider.of<List<User>>(context);
    if (_currentMembers == null) return Loading();

    _currentInvites = Application.currentGroup.invites ?? [];
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(Application.currentGroup.name),
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
                        _currentInvites[index],
                      ),
                    ),
                  ),
                  _buildInviteMemberForm(),
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
        leading: CircleAvatar(child: Text(user.initials())),
        title: Text(user.fullName()),
//        trailing: IconButton(
//          icon: Icon(
//            FontAwesomeIcons.userTimes,
//            size: 20,
//            color: theme.primaryColorLight,
//          ),
//          onPressed: () {
//            debugPrint('222');
//          },
//        ),
      ),
    );
  }

  Widget _buildInviteeTile(BuildContext context, String email) {
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
              FlushbarHelper(context, 'success', 'Invite removed for $email.').show();
            } catch (e) {
              FlushbarHelper(context, 'error', e.toString()).show();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInviteMemberForm() {
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
                  FlushbarHelper(context, 'error', '$email is already a group member...').show();
                } else if (_currentInvites.contains(email)) {
                  FlushbarHelper(context, 'error', '$email has already been invited...').show();
                } else {
                  try {
                    await GroupService().updateGroupInvites([
                      ..._currentInvites,
                      email,
                    ]);
                    setState(() => email = '');
                    FlushbarHelper(context, 'success', 'Group invite sent to $email.').show();
                  } catch (e) {
                    FlushbarHelper(context, 'error', e.toString()).show();
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
