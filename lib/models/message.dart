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

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
