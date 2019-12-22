import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/group.dart';

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
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
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
        .document(uid)
        .snapshots()
        .map((documentSnapshot) => User.fromDocumentSnapshot(documentSnapshot));
  }

  Stream<List<User>> get users {
    return userCollection.snapshots().map(userListFromSnapshot);
  }

  Stream<List<Group>> groups(User user) {
    final CollectionReference groupCollection = Firestore.instance.collection('groups');
    return groupCollection
        .where('members', arrayContains: user.uid)
        .snapshots()
        .map(GroupService().groupListFromSnapshot);
  }
}
