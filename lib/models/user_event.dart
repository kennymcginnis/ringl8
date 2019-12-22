import 'package:ringl8/models/user.dart';

class UserEvent {
  final User user;
  final DateTime dateTime;

  String uid;
  int status;
  bool isExpanded;

  UserEvent({
    this.uid,
    this.user,
    this.status,
    this.dateTime,
    this.isExpanded,
  });
}
