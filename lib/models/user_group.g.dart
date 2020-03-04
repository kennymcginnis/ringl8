// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGroup _$UserGroupFromJson(Map json) {
  return UserGroup(
    uid: json['uid'] as String,
    user: json['user'] as String,
    group: json['group'] as String,
    sunday: json['sunday'] as int,
    monday: json['monday'] as int,
    tuesday: json['tuesday'] as int,
    wednesday: json['wednesday'] as int,
    thursday: json['thursday'] as int,
    friday: json['friday'] as int,
    saturday: json['saturday'] as int,
  );
}

Map<String, dynamic> _$UserGroupToJson(UserGroup instance) => <String, dynamic>{
      'uid': instance.uid,
      'user': instance.user,
      'group': instance.group,
      'sunday': instance.sunday,
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
    };
