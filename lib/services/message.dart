import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/message.dart';

class MessageService {
  final CollectionReference messageCollection = Firestore.instance.collection('messages');

  Future sendMessage(Message message) async {
    return await messageCollection.add({
      'text': message.text,
      'senderUID': message.senderUID,
      'recipientUID': message.recipientUID,
      'timestamp': message.timestamp,
    });
  }

  List<Message> messageListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Message.fromDocumentSnapshot(documentSnapshot))
        .toList();
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
        .map(messageListFromSnapshot);
  }

  Stream<List<Message>> get messages {
    return messageCollection.snapshots().map(messageListFromSnapshot);
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
