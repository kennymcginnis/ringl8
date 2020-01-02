import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String uid;
  final String name;
  final String initials;
  final int color;
  final List<String> invites;
  final List<String> members;

  Group({this.uid, this.name, this.initials, this.color, this.invites, this.members});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  factory Group.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return Group(
      uid: documentSnapshot.documentID,
      name: documentSnapshot.data['name'] as String,
      initials: documentSnapshot.data['initials'] as String,
      color: documentSnapshot.data['color'] as int,
      invites: (documentSnapshot.data['invites'] as List)?.map((e) => e as String)?.toList(),
      members: (documentSnapshot.data['members'] as List)?.map((e) => e as String)?.toList(),
    );
  }

  Group copyWith(Group group) {
    return Group(
      uid: group.uid ?? this.uid,
      name: group.name ?? this.name,
      initials: group.initials ?? this.initials,
      color: group.color ?? this.color,
      invites: group.invites ?? this.invites,
      members: group.members ?? this.members,
    );
  }
}
