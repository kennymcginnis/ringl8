import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_group.g.dart';

@JsonSerializable(anyMap: true)
class UserGroup {
  final String uid;
  final String user;
  final String group;
  final int sunday;
  final int monday;
  final int tuesday;
  final int wednesday;
  final int thursday;
  final int friday;
  final int saturday;

  UserGroup({
    this.uid,
    this.user,
    this.group,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  UserGroup copyWith({
    uid,
    user,
    group,
    sunday,
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
  }) {
    return UserGroup(
      uid: uid ?? this.uid,
      user: user ?? this.user,
      group: group ?? this.group,
      sunday: sunday ?? this.sunday,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
    );
  }

  UserGroup updateStatus(String day, int value) {
    switch (day) {
      case 'sunday':
        return copyWith(sunday: value);
      case 'monday':
        return copyWith(monday: value);
      case 'tuesday':
        return copyWith(tuesday: value);
      case 'wednesday':
        return copyWith(wednesday: value);
      case 'thursday':
        return copyWith(thursday: value);
      case 'friday':
        return copyWith(friday: value);
      case 'saturday':
        return copyWith(saturday: value);
      default:
        return this;
    }
  }

  factory UserGroup.fromJson(Map<String, dynamic> json) => _$UserGroupFromJson(json);

  Map<String, dynamic> toJson() => _$UserGroupToJson(this);

  factory UserGroup.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return UserGroup(
      uid: documentSnapshot.data['uid'] as String,
      user: documentSnapshot.data['user'] as String,
      group: documentSnapshot.data['group'] as String,
      sunday: documentSnapshot.data['sunday'] as int,
      monday: documentSnapshot.data['monday'] as int,
      tuesday: documentSnapshot.data['tuesday'] as int,
      wednesday: documentSnapshot.data['wednesday'] as int,
      thursday: documentSnapshot.data['thursday'] as int,
      friday: documentSnapshot.data['friday'] as int,
      saturday: documentSnapshot.data['saturday'] as int,
    );
  }
}
