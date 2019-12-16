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
    return querySnapshot.documents.map((user) {
      print(user);
      var json = jsonDecode(jsonEncode(user.data));
      print(json);
      return User.fromJson(json);
    }).toList();
  }

  Stream<List<User>> get users {
    var snapshots = userCollection.snapshots();
    print(snapshots);
    return snapshots.map(_userListFromSnapshot);
  }
}
