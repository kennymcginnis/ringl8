import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/message.dart';
import 'package:ringl8/routes/app_state.dart';

class MessageService {
  final CollectionReference messageCollection = Firestore.instance.collection('messages');
  final application = sl.get<AppState>();

  Future sendMessage(String text) async {
    return await messageCollection.add({
      'text': text,
      'timestamp': DateTime.now(),
      'senderUID': application.currentUserUID,
      'recipientUID': application.currentGroupUID,
    });
  }

  List<Message> messageListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Message.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Query get messagesByRecipient {
    return messageCollection
        .where('recipientUID', isEqualTo: application.currentGroupUID)
        .orderBy('timestamp', descending: true);
  }

  Stream<List<Message>> get messages {
    return messageCollection
        .where('recipientUID', isEqualTo: application.currentGroupUID)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(messageListFromSnapshot);
  }
}
