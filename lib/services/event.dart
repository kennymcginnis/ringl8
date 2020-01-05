import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/routes/app_state.dart';

class EventService {
  final String uid;
  final application = sl.get<AppState>();

  EventService({this.uid});

  final CollectionReference eventCollection = Firestore.instance.collection('events');

  Future updateEvent(Event event) async {
    return await eventCollection.document(uid).setData({
      'user': event.userUID,
      'group': application.currentGroupUID,
      'status': event.status,
      'dateTime': event.dateTime,
    });
  }

  List<Event> eventListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((documentSnapshot) => Event.fromDocumentSnapshot(documentSnapshot))
        .toList();
  }

  Stream<List<Event>> get groupEvents {
    return eventCollection
        .where('groupUID', isEqualTo: application.currentGroupUID)
        .snapshots()
        .map(eventListFromSnapshot);
  }
}
