// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    uid: json['uid'] as String,
    user: json['user'] as String,
    status: json['status'] as int,
    dateTime: json['dateTime'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'uid': instance.uid,
      'user': instance.user,
      'status': instance.status,
      'dateTime': instance.dateTime,
    };
