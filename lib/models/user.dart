import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ringl8/models/user_group.dart';

part 'user.g.dart';

@JsonSerializable(anyMap: true)
class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final List<UserGroup> groups;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.groups,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromFirebase(FirebaseUser firebaseUser) {
    return User(uid: firebaseUser.uid, email: firebaseUser.email);
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return User(
      uid: documentSnapshot.documentID,
      firstName: documentSnapshot.data['firstName'] as String,
      lastName: documentSnapshot.data['lastName'] as String,
      email: documentSnapshot.data['email'] as String,
      avatar: documentSnapshot.data['avatar'] as String,
      groups: (documentSnapshot.data['groups'] as List)
          ?.map((e) => e == null ? null : UserGroup.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

  String fullName() => '${this.firstName} ${this.lastName}';

  String initials() => '${this.firstName.substring(0, 1)}${this.lastName.substring(0, 1)}';

  User copyWith({uid, firstName, lastName, email, avatar, groups}) {
    return User(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      groups: groups ?? this.groups,
    );
  }
}
