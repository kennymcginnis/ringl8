import 'package:flutter/material.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/models/user_event.dart';
import 'package:ringl8/screens/calendar/calendar.dart';
import 'package:ringl8/screens/calendar/styles.dart';
import 'package:ringl8/services/event.dart';
import 'package:ringl8/services/user.dart';

class CalendarDataLoader extends StatefulWidget {
  @override
  _CalendarDataLoaderState createState() => _CalendarDataLoaderState();
}

class _CalendarDataLoaderState extends State<CalendarDataLoader> with TickerProviderStateMixin {
  Map<String, User> _userMap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, User>>(
      stream: UserService().userMap,
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) return Loading();
        _userMap = userSnapshot.data;
        return StreamBuilder<List<Event>>(
          stream: EventService().events,
          builder: (context, eventSnapshot) {
            if (!eventSnapshot.hasData) return Loading();
            Map<DateTime, List> _currentEvents = _buildEventDataFromStream(eventSnapshot.data);
            return CalendarView(
              title: 'Group Member Calendar',
              userMap: _userMap,
              currentEvents: _currentEvents,
            );
          },
        );
      },
    );
  }

  List setDefaultIfAbsent(DateTime eventDate) {
    return _userMap.values.map((user) {
      return new UserEvent(
        user: user,
        dateTime: eventDate,
        status: UNKNOWN,
        isExpanded: false,
      );
    }).toList();
  }

  Map<DateTime, List> _buildEventDataFromStream(List<Event> events) {
    Map<DateTime, List> mapOutput = new Map<DateTime, List>();
    events.forEach((event) {
      DateTime eventDateTime = DateTime.parse(event.dateTime);
      List defaults = setDefaultIfAbsent(eventDateTime);
      mapOutput.putIfAbsent(eventDateTime, () => defaults.toList());

      UserEvent userEvent =
          mapOutput[eventDateTime].firstWhere((userEvent) => userEvent.user.uid == event.user);
      userEvent.uid = event.uid;
      userEvent.status = event.status;
    });
    return mapOutput;
  }
}
