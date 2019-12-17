import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/user.dart';

class UserService {
  final String uid;

  UserService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUser(User user) async {
    return await userCollection.document(uid).setData({
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
    });
  }

  User _userFromSnapshot(DocumentSnapshot documentSnapshot) {
    return User.fromJson(jsonDecode(jsonEncode(documentSnapshot.data)));
  }

  List<User> _userListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map(_userFromSnapshot).toList();
  }

  Stream<User> get user {
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }

  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
