import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:ringl8/models/app_state.dart';
import 'package:ringl8/screens/calendar/data_loader.dart';
import 'package:ringl8/screens/chat/chat.dart';
import 'package:ringl8/screens/user/memberships.dart';
import 'package:ringl8/screens/user/settings.dart';
import 'package:ringl8/screens/user/user_list.dart';

class ScreenListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<AppState>(
      properties: ['screen'],
      builder: (context, model, property) {
        switch (model.screen) {
          case 'chat':
            return ChatScreen();

          case 'group':
            return Memberships();

          case 'users':
            return UserList();

          case 'settings':
            return SettingsForm();

          case 'calendar':
            return CalendarDataLoader();

          default:
            return Text('Invalid choice');
        }
      },
    );
  }
}
