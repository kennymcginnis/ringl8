import 'package:provider/provider.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/models/wrapper.dart';
import 'package:ringl8/services/event.dart';
import 'package:ringl8/services/group.dart';
import 'package:ringl8/services/user.dart';

StreamProvider<User> userProvider() {
  return StreamProvider<User>.value(
    value: UserService().user,
  );
}

// _ = Map<String, List<String>> params
StreamProvider<Membership> membershipProvider() {
  return StreamProvider<Membership>.value(
    value: GroupService().membership,
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

StreamProvider<List<User>> membersProvider() {
  return StreamProvider<List<User>>.value(
    value: UserService().groupMembers,
  );
}

StreamProvider<List<Event>> eventProvider() {
  return StreamProvider<List<Event>>.value(
    value: EventService().groupEvents,
  );
}

StreamProvider<Map<String, User>> userMapProvider() {
  return StreamProvider<Map<String, User>>.value(
    value: UserService().userMap,
  );
}
