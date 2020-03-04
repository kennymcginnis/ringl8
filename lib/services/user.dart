import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/app_state.dart';

class UserService {
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final application = sl.get<AppState>();

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

  Stream<User> get user {
    if (application.currentUserUID == null) return null;
    return userCollection
        .document(application.currentUserUID)
        .snapshots()
        .map((documentSnapshot) => User.fromDocumentSnapshot(documentSnapshot));
  }

  Stream<List<User>> groupMembers(List<String> users) {
    return userCollection.where('uid', whereIn: users).snapshots().map(userListFromSnapshot);
  }
}
