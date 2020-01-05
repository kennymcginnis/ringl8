import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthUser {
  final String uid;
  final String email;

  AuthUser({this.uid, this.email});

  factory AuthUser.fromFirebase(FirebaseUser firebaseUser) {
    return AuthUser(uid: firebaseUser.uid, email: firebaseUser.email);
  }
}
