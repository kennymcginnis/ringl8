import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/message.dart';

class MessageService {
  final CollectionReference messageCollection = Firestore.instance.collection('messages');

  Future sendMessage(Message message) async {
    return await messageCollection.document(message.uid).setData({
      'text': message.text,
      'senderUID': message.senderUID,
      'recipientUID': message.recipientUID,
      'timestamp': message.timestamp,
    });
  }

  Message _messageFromSnapshot(DocumentSnapshot documentSnapshot) {
    return Message(
      uid: documentSnapshot.data['uid'] as String,
      text: documentSnapshot.data['text'] as String,
      senderUID: documentSnapshot.data['senderUID'] as String,
      timestamp: documentSnapshot.data['timestamp'] == null
          ? null
          : DateTime.parse(documentSnapshot.data['timestamp'] as String),
      recipientUID: documentSnapshot.data['recipientUID'] as String,
    );
  }

  List<Message> _messageListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map(_messageFromSnapshot).toList();
  }

  Query messagesByRecipient(String recipientUID) {
    return messageCollection
        .where('recipientUID', isEqualTo: recipientUID)
        .orderBy('timestamp', descending: true);
  }

  Stream<List<Message>> messageStreamByRecipient(String recipientUID) {
    return messageCollection
        .where('recipientUID', isEqualTo: recipientUID)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_messageListFromSnapshot);
  }

  Stream<List<Message>> get messages {
    return messageCollection.snapshots().map(_messageListFromSnapshot);
  }

//  List<Message> _messageListFromSnapshot(QuerySnapshot querySnapshot) {
//    return querySnapshot.documents.map((message) {
//      print(message);
//      var json = jsonDecode(jsonEncode(message.data));
//      print(json);
//      return Message.fromJson(json);
//    }).toList();
//  }
//
//  Stream<List<Message>> get messages {
//    var snapshots = messageCollection.snapshots();
//    print(snapshots);
//    return snapshots.map(_messageListFromSnapshot);
//  }
}
