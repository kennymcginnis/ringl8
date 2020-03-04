import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/user_group.dart';
import 'package:ringl8/routes/app_state.dart';

class UserGroupService {
  final uid;

  UserGroupService({this.uid});

  final CollectionReference userGroupCollection = Firestore.instance.collection('users_groups');
  final application = sl.get<AppState>();

  Future updateUserGroup(UserGroup userGroup) {
    return userGroupCollection.document(uid).setData({
      'user': userGroup.user,
      'group': userGroup.group,
      'sunday': userGroup.sunday,
      'monday': userGroup.monday,
      'tuesday': userGroup.tuesday,
      'wednesday': userGroup.wednesday,
      'thursday': userGroup.thursday,
      'friday': userGroup.friday,
      'saturday': userGroup.saturday,
    });
  }

  List<UserGroup> userGroupListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => UserGroup.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Map<String, UserGroup> _userGroupMapFromSnapshot(QuerySnapshot querySnapshot) {
    return Map.fromIterable(
      userGroupListFromSnapshot(querySnapshot),
      key: (item) => item.uid,
      value: (item) => item,
    );
  }

  Stream<List<UserGroup>> get usersGroups {
    if (application.currentUserUID == null) return null;
    if (application.currentGroupUID == null) return null;
    return userGroupCollection
        .where('user', isEqualTo: application.currentUserUID)
        .where('group', isEqualTo: application.currentGroupUID)
        .snapshots()
        .map(userGroupListFromSnapshot);
  }

  Map<String, UserGroup> userGroupMapFromList(List<UserGroup> userGroups) {
    return new Map<String, UserGroup>.fromIterable(userGroups,
        key: (item) => item.uid, value: (item) => item);
  }

  Stream<Map<String, UserGroup>> get userGroupMap {
    if (application.currentUserUID == null) return null;
    if (application.currentGroupUID == null) return null;
    return userGroupCollection
        .where('user', isEqualTo: application.currentUserUID)
        .where('group', isEqualTo: application.currentGroupUID)
        .snapshots()
        .map(_userGroupMapFromSnapshot);
  }

  Stream<List<UserGroup>> get groupMembers {
    if (application.currentGroupUID == null) return null;
    return userGroupCollection
        .where('group', isEqualTo: application.currentGroupUID)
        .snapshots()
        .map(UserGroupService().userGroupListFromSnapshot);
  }
}
