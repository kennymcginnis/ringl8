import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:ringl8/models/app_state.dart';
import 'package:ringl8/screens/chat/chat.dart';
import 'package:ringl8/screens/group/status.dart';
import 'package:ringl8/screens/user/settings.dart';
import 'package:ringl8/screens/user/user_list.dart';

class ScreenListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<AppState>(
      properties: ['screen'],
      builder: (context, model, property) {
        switch (model.screen) {
          case 'group':
            return GroupStatus();

          case 'chat':
            return ChatScreen();

          case 'users':
            return UserList();

          case 'settings':
            return SettingsForm();

          default:
            return Text('Invalid choice');
        }
      },
    );
  }
}
