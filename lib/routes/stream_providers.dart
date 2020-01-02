import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/event.dart';
import 'package:ringl8/services/group.dart';
import 'package:ringl8/services/user.dart';

// _ = Map<String, List<String>> params
StreamProvider<List<Group>> groupsProvider() {
  return StreamProvider<List<Group>>.value(
    value: UserService().groups,
  );
}

StreamProvider<List<User>> membersProvider() {
  return StreamProvider<List<User>>.value(
    value: UserService().groupMembers,
  );
}

StreamProvider<Map<String, User>> userMapProvider() {
  return StreamProvider<Map<String, User>>.value(
    value: UserService().userMap,
  );
}

StreamProvider<User> userProvider() {
  return StreamProvider<User>.value(
    value: UserService().user,
  );
}

StreamProvider<List<Event>> eventProvider() {
  return StreamProvider<List<Event>>.value(
    value: EventService().events,
  );
}
