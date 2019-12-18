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
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'uid': instance.uid,
      'text': instance.text,
      'senderUID': instance.senderUID,
      'recipientUID': instance.recipientUID,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
