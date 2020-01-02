import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/group.dart';

import '../routes/application.dart';

class UserService {
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Map<String, User> userMapFromList(List<User> users) {
    return new Map<String, User>.fromIterable(users,
        key: (item) => item.uid, value: (item) => item);
  }

  Future updateUser(User user) async {
    return await userCollection.document(Application.currentUserUID).setData({
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'avatar': user.avatar,
    });
  }

  List<User> userListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => User.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Map<String, User> _userMapFromSnapshot(QuerySnapshot querySnapshot) {
    return Map.fromIterable(
      userListFromSnapshot(querySnapshot),
      key: (item) => item.uid,
      value: (item) => item,
    );
  }

  Stream<Map<String, User>> get userMap {
    return userCollection.snapshots().map(_userMapFromSnapshot);
  }

  Stream<User> get user {
    return userCollection
        .document(Application.currentUserUID)
        .snapshots()
        .map((documentSnapshot) => User.fromDocumentSnapshot(documentSnapshot));
  }

  Stream<List<User>> get users {
    return userCollection.snapshots().map(userListFromSnapshot);
  }

  Stream<List<Group>> get groups {
    final CollectionReference groupCollection = Firestore.instance.collection('groups');
    return groupCollection
        .where('members', arrayContains: Application.currentUserUID)
        .snapshots()
        .map(GroupService().groupListFromSnapshot);
  }

  Stream<List<User>> get groupMembers {
    final CollectionReference userCollection = Firestore.instance.collection('users');
    return userCollection
        .where('uid', whereIn: Application.currentGroup.members)
        .snapshots()
        .map(UserService().userListFromSnapshot);
  }
}
