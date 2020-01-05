import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/group.dart';
import 'package:ringl8/models/wrapper.dart';
import 'package:ringl8/routes/app_state.dart';

class GroupService {
  final CollectionReference groupCollection = Firestore.instance.collection('groups');
  final application = sl.get<AppState>();

  Future createGroup(String name) async {
    return await groupCollection.add({
      'name': name,
      'initials': name.substring(0, 2),
      'members': [application.currentUserUID],
    });
  }

  Future updateGroupSettings(Group group) async {
    return await groupCollection.document(application.currentGroupUID).updateData({
      'name': group.name,
      'initials': group.initials,
      'color': group.color,
    });
  }

  Future updateGroupMembers(List<String> members) {
    return groupCollection.document(application.currentGroupUID).updateData({
      'members': members,
    });
  }

  Future updateGroupInvites(List<String> invites) {
    return groupCollection.document(application.currentGroupUID).updateData({
      'invites': invites,
    });
  }

  Membership membershipFromSnapshot(QuerySnapshot querySnapshot) {
    return Membership(groupListFromSnapshot(querySnapshot));
  }

  Invitations invitationsFromSnapshot(QuerySnapshot querySnapshot) {
    return Invitations(groupListFromSnapshot(querySnapshot));
  }

  List<Group> groupListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Group.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Stream<Group> get group {
    print(application.currentGroupUID);
    if (application.currentGroupUID == null) return null;
    return groupCollection
        .document(application.currentGroupUID)
        .snapshots()
        .map((documentSnapshot) => Group.fromDocumentSnapshot(documentSnapshot));
  }

  Stream<Membership> get membership {
    if (application.currentUserUID == null) return null;
    return groupCollection
        .where('members', arrayContains: application.currentUserUID)
        .snapshots()
        .map(membershipFromSnapshot);
  }

  Stream<Invitations> get invitations {
    if (application.currentUserEmail == null) return null;
    return groupCollection
        .where('invites', arrayContains: application.currentUserEmail)
        .snapshots()
        .map(invitationsFromSnapshot);
  }
}
