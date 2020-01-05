import 'package:flutter/material.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/helpers/flushbar.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/services/group.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String _currentName = '';

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();

    void handleSubmit() async {
      if (_formKey.currentState.validate()) {
        setState(() => loading = true);
        try {
          await GroupService().createGroup(_currentName);
          FlushbarHelper(context, Status.success, '$_currentName group created.').show();
        } catch (e) {
          FlushbarHelper(context, Status.error, e.toString()).show();
        } finally {
          setState(() => loading = false);
        }
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
              onChanged: (value) => setState(() => _currentName = value),
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
