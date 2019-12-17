import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/message.dart';

class MessageService {
  final String uid;

  MessageService({this.uid});

  final CollectionReference messageCollection =
      Firestore.instance.collection('messages');

  List<Message> _messageListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((message) {
      print(message);
      var json = jsonDecode(jsonEncode(message.data));
      print(json);
      return Message.fromJson(json);
    }).toList();
  }

  Stream<List<Message>> get messages {
    var snapshots = messageCollection.snapshots();
    print(snapshots);
    return snapshots.map(_messageListFromSnapshot);
  }
}
