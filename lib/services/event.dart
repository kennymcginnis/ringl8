import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/models/event.dart';

class EventService {
  final String uid;

  EventService({this.uid});

  final CollectionReference eventCollection = Firestore.instance.collection('events');

  Future updateEvent(Event event) async {
    return await eventCollection.document(uid).setData({
      'user': event.user,
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

  Stream<List<Event>> findByUserAndDateTime(String user, DateTime dateTime) {
    return eventCollection
        .where('user', isEqualTo: user)
        .where('dateTime', isEqualTo: dateTime)
        .limit(1)
        .snapshots()
        .map(eventListFromSnapshot);
  }

  Stream<List<Event>> eventsForGroupMembers(List<String> members) {
    return eventCollection
        .where('user', whereIn: members)
        .snapshots()
        .map(eventListFromSnapshot);
  }
}
