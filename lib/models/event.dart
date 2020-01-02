import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String uid;
  final String userUID;
  final String groupUID;
  final int status;
  final String dateTime;

  Event({this.uid, this.userUID, this.groupUID, this.status, this.dateTime});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Event(
      uid: documentSnapshot.documentID,
      userUID: documentSnapshot.data['userUID'],
      groupUID: documentSnapshot.data['groupUID'],
      status: documentSnapshot.data['status'],
      dateTime: documentSnapshot.data['dateTime'],
    );
  }

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
