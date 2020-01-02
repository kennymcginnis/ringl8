import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final List<String> groups;

  User({this.uid, this.firstName, this.lastName, this.email, this.avatar, this.groups});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

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
      groups: (documentSnapshot.data['groups'] as List)?.map((e) => e as String)?.toList(),
    );
  }

  String fullName() => '${this.firstName} ${this.lastName}';

  String initials() => '${this.firstName.substring(0, 1)}${this.lastName.substring(0, 1)}';

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith(User user) {
    return User(
      uid: user.uid ?? this.uid,
      firstName: user.firstName ?? this.firstName,
      lastName: user.lastName ?? this.lastName,
      email: user.email ?? this.email,
      avatar: user.avatar ?? this.avatar,
      groups: user.groups ?? this.groups,
    );
  }
}
