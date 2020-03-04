import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
      'user': event.user,
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
        .where('group', isEqualTo: application.currentGroupUID)
        .snapshots()
        .map(eventListFromSnapshot);
  }

  Stream<List<Event>> get userCurrentEvent {
    if (application.currentUserUID == null || application.currentGroupUID == null) return null;
    final formatter = new DateFormat('yyyy-MM-dd');
    return eventCollection
        .where('user', isEqualTo: application.currentUserUID)
        .where('group', isEqualTo: application.currentGroupUID)
        .where('dateTime', isEqualTo: formatter.format(DateTime.now()))
        .snapshots()
        .map(eventListFromSnapshot);
  }
}
