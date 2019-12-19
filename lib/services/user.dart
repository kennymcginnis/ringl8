import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/user.dart';

class UserService {
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final String uid;

  UserService({this.uid});

  Map<String, User> userMapFromList(List<User> users) {
    return new Map<String, User>.fromIterable(users,
        key: (item) => item.uid, value: (item) => item);
  }

  Future updateUser(User user) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
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

  Map<String, User> _userMapFromSnapshot(QuerySnapshot querySnapshot) {
    return Map.fromIterable(
      querySnapshot.documents.map(_userFromSnapshot).toList(),
      key: (item) => item.uid,
      value: (item) => item,
    );
  }

  Stream<Map<String, User>> get userMap {
    var map = userCollection.snapshots().map(_userMapFromSnapshot);
    return map;
  }

  Stream<User> get user {
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }

  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
