import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/group_icon.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/user_group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/screens/calendar/styles.dart';

class UsersGroupDefaults extends StatefulWidget {
  @override
  UsersGroupDefaultsState createState() => UsersGroupDefaultsState();
}

class UsersGroupDefaultsState extends State<UsersGroupDefaults> {
  final application = sl.get<AppState>();

  final List<Choice> choices = <Choice>[
    Choice(title: 'sunday'),
    Choice(title: 'monday'),
    Choice(title: 'tuesday'),
    Choice(title: 'wednesday'),
    Choice(title: 'thursday'),
    Choice(title: 'friday'),
    Choice(title: 'saturday'),
  ];

  UserGroup _currentGroupDefaults;

  @override
  Widget build(BuildContext context) {
    User _currentUser = Provider.of<User>(context);
    _currentGroupDefaults = _currentUser.groups.firstWhere((groupDefault) {
          return groupDefault.group == application.currentGroupUID;
        }) ??
        UserGroup(group: application.currentGroupUID);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            GroupIcon(application.currentGroup, size: Size.small),
            SizedBox(width: 10.0),
            Text('Set Defaults for Group'),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: choices.map((choice) {
            return Row(
              children: [RED, YELLOW, GREEN].map((status) {
                return _buildFloatingActionButton(choice.title, status);
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(String day, int status) {
    return Builder(builder: (context) {
      return FloatingActionButton(
        heroTag: 'setStatus$status',
        onPressed: () {
          setState(() => _currentGroupDefaults = _currentGroupDefaults.updateStatus(day, status));
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: ICON_COLOR[status],
        child: Icon(ICON[status], size: 32.0),
      );
    });
  }
}
