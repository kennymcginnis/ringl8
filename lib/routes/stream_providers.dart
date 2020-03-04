import 'package:provider/provider.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/models/user_group.dart';
import 'package:ringl8/models/wrapper.dart';
import 'package:ringl8/services/event.dart';
import 'package:ringl8/services/group.dart';
import 'package:ringl8/services/user.dart';
import 'package:ringl8/services/user_group.dart';

// _ = Map<String, List<String>> params
StreamProvider<User> userProvider() {
  return StreamProvider<User>.value(
    value: UserService().user,
  );
}

StreamProvider<List<UserGroup>> groupMembersProvider() {
  return StreamProvider<List<UserGroup>>.value(
    value: UserGroupService().groupMembers,
  );
}

StreamProvider<Invitations> invitationsProvider() {
  return StreamProvider<Invitations>.value(
    value: GroupService().invitations,
  );
}

StreamProvider<Group> groupProvider() {
  return StreamProvider<Group>.value(
    value: GroupService().group,
  );
}

StreamProvider<List<Event>> eventProvider() {
  return StreamProvider<List<Event>>.value(
    value: EventService().groupEvents,
  );
}

StreamProvider<List<Event>> currentEventProvider() {
  return StreamProvider<List<Event>>.value(
    value: EventService().userCurrentEvent,
  );
}

StreamProvider<Map<String, User>> userMapProvider() {
  return StreamProvider<Map<String, User>>.value(
    value: UserService().userMap,
  );
}
