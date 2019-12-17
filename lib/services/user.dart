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

  List<User> _userListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((user) => User.fromJson(jsonDecode(jsonEncode(user.data))))
        .toList();
  }

  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
