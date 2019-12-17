import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String uid;
  String text;
  String senderUID;
  String recipientUID;
  Timestamp timestamp;

  Message({this.uid, this.text, this.senderUID, this.timestamp, this.recipientUID});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
