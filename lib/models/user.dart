import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:ringl8/models/group.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String name;
  final String email;
  final List<Group> groups;

  User({this.uid, this.name, this.email, this.groups});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

//  static Future<List<User>> fetchAll() async {
//    var uri = Endpoint.uri('/users');
//
//    final resp = await http.get(uri.toString());
//
//    if (resp.statusCode != 200) {
//      throw (resp.body);
//    }
//    List<User> list = new List<User>();
//    for (var jsonItem in json.decode(resp.body)) {
//      list.add(User.fromJson(jsonItem));
//    }
//    return list;
//  }
//
//  static Future<User> fetchByID(int id) async {
//    var uri = Endpoint.uri('/users/$id');
//
//    final resp = await http.get(uri.toString());
//
//    if (resp.statusCode != 200) {
//      throw (resp.body);
//    }
//    final Map<String, dynamic> itemMap = json.decode(resp.body);
//    return User.fromJson(itemMap);
//  }
}
