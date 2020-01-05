import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/app_state.dart';

class UserService {
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final application = sl.get<AppState>();

  Map<String, User> userMapFromList(List<User> users) {
    return new Map<String, User>.fromIterable(users,
        key: (item) => item.uid, value: (item) => item);
  }

  Future updateUser(User user) {
    return userCollection.document(application.currentUserUID).setData({
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

  Stream<List<User>> get users {
    return userCollection.snapshots().map(userListFromSnapshot);
  }

  Stream<Map<String, User>> get userMap {
    return userCollection.snapshots().map(_userMapFromSnapshot);
  }

  Stream<User> get user {
    if (application.currentUserUID == null) return null;
    return userCollection
        .document(application.currentUserUID)
        .snapshots()
        .map((documentSnapshot) => User.fromDocumentSnapshot(documentSnapshot));
  }

  Stream<List<User>> get groupMembers {
    if (application.currentGroup?.members == null) return null;
    return userCollection
        .where('uid', whereIn: application.currentGroup.members)
        .snapshots()
        .map(UserService().userListFromSnapshot);
  }
}
