import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/group_icon.dart';
import 'package:ringl8/components/square_menu_button.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/wrapper.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/routes/application.dart';

class HomeComponent extends StatelessWidget {
  final application = sl.get<AppState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final childRatio = (size.width / size.height) * 2.5;
    List<Group> _currentGroups = Provider.of<Membership>(context)?.membership ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('RINGL8 (running late)'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text('My Groups:', style: TextStyle(fontSize: 18.0)),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: <Widget>[
                  GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: 1,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: _currentGroups.map((Group group) {
                      return GroupIcon(
                        group,
                        onTap: () {
                          application.currentGroup = group;
                          application.currentGroupUID = group.uid;
                          return Application.router.navigateTo(
                            context,
                            '/group',
                            transition: TransitionType.fadeIn,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: childRatio,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: [
                  SquareMenuButton(
                    icon: Icons.group,
                    text: 'Manage Groups',
                    navigateTo: '/groups',
                  ),
                  SquareMenuButton(
                    icon: FontAwesomeIcons.calendarAlt,
                    text: 'Calendar',
                    navigateTo: '/calendar',
                  ),
                  SquareMenuButton(
                    icon: Icons.settings,
                    text: 'Settings',
                    navigateTo: '/settings',
                  ),
                  SquareMenuButton(
                    icon: Icons.exit_to_app,
                    text: 'Log Out',
                    navigateTo: '/logout',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
