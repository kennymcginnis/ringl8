import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ringl8/models/group.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String uid;
  String firstName;
  String lastName;
  String email;
  List<Group> groups;

  User({this.uid, this.firstName, this.lastName, this.email, this.groups});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirebase(FirebaseUser firebaseUser) {
    return User(uid: firebaseUser.uid, email: firebaseUser.email);
  }

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
      uid: data['uid'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

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
