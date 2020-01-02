import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/routes/stream_providers.dart';
import 'package:ringl8/screens/authenticate/auth_form.dart';
import 'package:ringl8/screens/calendar/calendar_view.dart';
import 'package:ringl8/screens/chat/chat.dart';
import 'package:ringl8/screens/group/customize.dart';
import 'package:ringl8/screens/group/home.dart';
import 'package:ringl8/screens/group/members.dart';
import 'package:ringl8/screens/home/home.dart';
import 'package:ringl8/screens/user/groups.dart';
import 'package:ringl8/screens/user/settings.dart';
import 'package:ringl8/services/auth.dart';

import 'application.dart';

var authHandler = Handler(handlerFunc: (BuildContext context, _) {
  if (Application.currentUserUID == null) return AuthForm();
  return MultiProvider(
    providers: [
      groupsProvider(),
    ],
    child: HomeComponent(),
  );
});

var homeHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      groupsProvider(),
    ],
    child: HomeComponent(),
  );
});

var groupHandler = Handler(handlerFunc: (BuildContext context, _) => GroupHome());

var customizeHandler = Handler(handlerFunc: (BuildContext context, _) => CustomizeGroup());

var membersHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      membersProvider(),
    ],
    child: GroupMembers(),
  );
});

var groupsHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      groupsProvider(),
    ],
    child: UsersGroups(),
  );
});

var chatHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      userMapProvider(),
      userProvider(),
    ],
    child: Material(child: ChatScreen()),
  );
});

Handler calendarHandler(showListOnly) {
  return Handler(handlerFunc: (BuildContext context, _) {
    return MultiProvider(
      providers: [
        userMapProvider(),
        eventProvider(),
      ],
      child: CalendarView(showListOnly: showListOnly),
    );
  });
}

var invitationsHandler = Handler(handlerFunc: (BuildContext context, _) {
  return Container(width: 0, height: 0); // TODO
});

var settingsHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      userProvider(),
    ],
    child: SettingsForm(),
  );
});

var logoutHandler = Handler(handlerFunc: (BuildContext context, _) {
  AuthService().signOut();
  return AuthForm();
});
