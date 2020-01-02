import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/event.dart';

import '../routes/application.dart';

class EventService {
  final String uid;

  EventService({this.uid});

  final CollectionReference eventCollection = Firestore.instance.collection('events');

  Future updateEvent(Event event) async {
    return await eventCollection.document(uid).setData({
      'user': event.userUID,
      'group': Application.currentGroupUID,
      'status': event.status,
      'dateTime': event.dateTime,
    });
  }

  List<Event> eventListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Event.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Stream<List<Event>> get events {
    return eventCollection.snapshots().map(eventListFromSnapshot);
  }

  Stream<List<Event>> get groupEvents {
    return eventCollection
        .where('groupUID', isEqualTo: Application.currentGroupUID)
        .snapshots()
        .map(eventListFromSnapshot);
  }
}
