import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/user.dart';

class GroupService {
  final String uid;

  GroupService({this.uid});

  final CollectionReference groupCollection = Firestore.instance.collection('groups');

  Future createGroup(String name, String currentUser) async {
    return await groupCollection.add({
      'name': name,
      'members': [currentUser],
    });
  }

  Future inviteGroupMember(Group group) async {
    return await groupCollection.document(uid).updateData({
      'invites': group.invites,
    });
  }

  List<Group> groupListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Group.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Stream<Group> get group {
    return groupCollection
        .document(uid)
        .snapshots()
        .map((documentSnapshot) => Group.fromDocumentSnapshot(documentSnapshot));
  }
}
