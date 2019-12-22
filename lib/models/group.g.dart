// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    uid: json['uid'] as String,
    name: json['name'] as String,
    invites: (json['invites'] as List)?.map((e) => e as String)?.toList(),
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'invites': instance.invites,
      'members': instance.members,
    };
