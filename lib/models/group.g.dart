// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    uid: json['uid'] as String,
    name: json['name'] as String,
    initials: json['initials'] as String,
    color: json['color'] as int,
    invites: (json['invites'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'initials': instance.initials,
      'color': instance.color,
      'invites': instance.invites,
    };
