import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String uid;
  final String user;
  final String group;
  final int status;
  final String dateTime;

  Event({this.uid, this.user, this.group, this.status, this.dateTime});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Event(
      uid: documentSnapshot.documentID,
      user: documentSnapshot.data['user'],
      group: documentSnapshot.data['group'],
      status: documentSnapshot.data['status'],
      dateTime: documentSnapshot.data['dateTime'],
    );
  }

  Map<String, dynamic> toJson() => _$EventToJson(this);

  Event copyWith({uid, user, group, status, dateTime}) {
    return Event(
      uid: uid ?? this.uid,
      user: user ?? this.user,
      group: group ?? this.group,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
