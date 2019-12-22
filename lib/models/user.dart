import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ringl8/models/group.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> groups;

  User({this.uid, this.firstName, this.lastName, this.email, this.groups});

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
      groups: (documentSnapshot.data['groups'] as List)?.map((e) => e as String)?.toList(),
    );
  }

  String fullName() => '${this.firstName} ${this.lastName}';

  String initials() => '${this.firstName.substring(0, 1)}${this.lastName.substring(0, 1)}';

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.clone(
    User user, {
    String uid,
    String firstName,
    String lastName,
    String email,
    List<Group> groups,
  }) {
    return User(
      uid: uid ?? user.uid,
      firstName: firstName ?? user.firstName,
      lastName: lastName ?? user.lastName,
      email: email ?? user.email,
      groups: groups ?? user.groups,
    );
  }
}
