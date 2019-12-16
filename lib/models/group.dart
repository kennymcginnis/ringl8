import 'package:json_annotation/json_annotation.dart';
import 'package:ringl8/models/user.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final String name;
  final List<User> members;

  Group({this.name, this.members});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
