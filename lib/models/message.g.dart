// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    uid: json['uid'] as String,
    text: json['text'] as String,
    senderUID: json['senderUID'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    recipientUID: json['recipientUID'] as String,
  )
    ..sender = json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>)
    ..recipient = json['recipient'] == null
        ? null
        : User.fromJson(json['recipient'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'uid': instance.uid,
      'text': instance.text,
      'sender': instance.sender,
      'recipient': instance.recipient,
      'senderUID': instance.senderUID,
      'recipientUID': instance.recipientUID,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
