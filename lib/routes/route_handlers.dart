import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/auth_user.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/routes/stream_providers.dart';
import 'package:ringl8/screens/authenticate/auth_form.dart';
import 'package:ringl8/screens/calendar/calendar_view.dart';
import 'package:ringl8/screens/chat/chat.dart';
import 'package:ringl8/screens/group/customize.dart';
import 'package:ringl8/screens/group/home.dart';
import 'package:ringl8/screens/group/members.dart';
import 'package:ringl8/screens/home/home.dart';
import 'package:ringl8/screens/user/defaults.dart';
import 'package:ringl8/screens/user/home.dart';
import 'package:ringl8/screens/user/settings.dart';
import 'package:ringl8/services/auth.dart';

final application = sl.get<AppState>();

var authHandler = Handler(handlerFunc: (BuildContext context, _) {
  AuthUser _currentUser = Provider.of<AuthUser>(context);
  if (_currentUser == null) return AuthForm();
  application.currentUserUID = _currentUser.uid;
  application.currentUserEmail = _currentUser.email;
  return MultiProvider(
    providers: [
      userProvider(),
      membershipProvider(),
    ],
    child: HomeComponent(),
  );
});

var groupHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      currentEventProvider(),
    ],
    child: GroupHome(),
  );
});

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
      membershipProvider(),
      invitationsProvider(),
    ],
    child: UsersHome(),
  );
});

var chatHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      userMapProvider(),
      userProvider(),
    ],
    child: ChatScreen(),
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

var defaultsHandler = Handler(handlerFunc: (BuildContext context, _) {
  return MultiProvider(
    providers: [
      userProvider(),
    ],
    child: UsersGroupDefaults(),
  );
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
  application.currentUserUID = null;
  application.currentUserEmail = null;
  return AuthForm();
});
