import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String uid;
  final String name;
  final List<String> invites;
  final List<String> members;

  Group({this.uid, this.name, this.invites, this.members});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Group(
      uid: documentSnapshot.documentID,
      name: documentSnapshot.data['name'] as String,
      invites: (documentSnapshot.data['invites'] as List)?.map((e) => e as String)?.toList(),
      members: (documentSnapshot.data['members'] as List)?.map((e) => e as String)?.toList(),
    );
  }
}
