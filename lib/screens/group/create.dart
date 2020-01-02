import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/group.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    String _userUID = Provider.of<User>(context).uid;

    void handleSubmit() async {
      if (_formKey.currentState.validate()) {
        setState(() => loading = true);
        await GroupService().createGroup(name, _userUID);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            InputTextField(
              icon: Icons.group,
              labelText: 'Group Name',
              onChanged: (value) => setState(() => name = value),
              validator: (value) => Validators.validateString(value, 'name'),
            ),
            SizedBox(height: 20.0),
            ExtendedButton(
              text: 'Create Group',
              onTap: handleSubmit,
            ),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
