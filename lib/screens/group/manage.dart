import 'package:flutter/material.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/components/validators.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/services/group.dart';

class ManageGroup extends StatefulWidget {
  final String uid;

  ManageGroup({this.uid});

  @override
  _ManageGroupState createState() => _ManageGroupState();
}

class _ManageGroupState extends State<ManageGroup> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Group>(
      stream: GroupService(uid: widget.uid).group,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        Group _currentGroup = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text('ManageGroup'),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  InputTextField(
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    onChanged: (value) => setState(() => email = value),
                    validator: Validators.validateEmail,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Invite Group Member'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        _currentGroup.invites.add(email);
                        await GroupService().inviteGroupMember(_currentGroup);
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
//              Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
