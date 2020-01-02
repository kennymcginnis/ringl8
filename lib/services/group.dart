import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/routes/application.dart';

class GroupService {
  final CollectionReference groupCollection = Firestore.instance.collection('groups');

  Future createGroup(String name, String currentUser) async {
    return await groupCollection.add({
      'name': name,
      'initials': name.substring(0, 2),
      'members': [currentUser],
    });
  }

  Future updateGroupSettings(Group group) async {
    return await groupCollection.document(Application.currentGroupUID).updateData({
      'name': group.name,
      'initials': group.initials,
      'color': group.color,
    });
  }

  Future updateGroupInvites(List<String> invites) async {
    return await groupCollection.document(Application.currentGroupUID).updateData({
      'invites': invites,
    });
  }

  List<Group> groupListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Group.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Stream<Group> get group {
    if (Application.currentGroupUID == null) return null;
    return groupCollection
        .document(Application.currentGroupUID)
        .snapshots()
        .map((documentSnapshot) => Group.fromDocumentSnapshot(documentSnapshot));
  }
}
