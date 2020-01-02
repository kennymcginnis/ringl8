import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/message.dart';
import 'package:ringl8/routes/application.dart';

class MessageService {
  final CollectionReference messageCollection = Firestore.instance.collection('messages');

  Future sendMessage(String text) async {
    return await messageCollection.add({
      'text': text,
      'timestamp': DateTime.now(),
      'senderUID': Application.currentUserUID,
      'recipientUID': Application.currentGroupUID,
    });
  }

  List<Message> messageListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Message.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Query get messagesByRecipient {
    return messageCollection
        .where('recipientUID', isEqualTo: Application.currentGroupUID)
        .orderBy('timestamp', descending: true);
  }

  Stream<List<Message>> get messages {
    return messageCollection
        .where('recipientUID', isEqualTo: Application.currentGroupUID)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(messageListFromSnapshot);
  }
}
