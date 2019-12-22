import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ringl8/models/user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String uid;
  String text;
  User sender;
  User recipient;
  String senderUID;
  String recipientUID;
  DateTime timestamp;

  Message({this.uid, this.text, this.senderUID, this.timestamp, this.recipientUID});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  factory Message.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Message(
      uid: documentSnapshot.documentID,
      text: documentSnapshot.data['text'] as String,
      senderUID: documentSnapshot.data['senderUID'] as String,
      timestamp: documentSnapshot.data['timestamp'] == null
          ? null
          : DateTime.parse(documentSnapshot.data['timestamp'] as String),
      recipientUID: documentSnapshot.data['recipientUID'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
