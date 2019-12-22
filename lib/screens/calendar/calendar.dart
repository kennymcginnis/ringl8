import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/models/user_event.dart';
import 'package:ringl8/screens/calendar/event_list.dart';
import 'package:table_calendar/table_calendar.dart';

import 'styles.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    Key key,
    this.title,
    this.userMap,
    this.currentEvents,
  }) : super(key: key);

  final String title;
  final Map<String, User> userMap;
  final Map<DateTime, List> currentEvents;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  final formatter = new DateFormat('yyyy-MM-dd');

  DateTime _selectedDay;
  int _selectedFilter;
  List _selectedEvents;
  DecorationImage _backgroundImage;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.parse(formatter.format(DateTime.now()));
    _backgroundImage = months[DateTime.now().month];

    _calendarController = CalendarController();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() => _selectedDay = DateTime.parse(formatter.format(day)));
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    setState(() => _backgroundImage = months[first.month]);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    setEventsForSelectedDay();
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            //alignment: buttonSwingAnimation.value,
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                width: screenSize.width,
                height: screenSize.height / 2.5,
                decoration: BoxDecoration(image: _backgroundImage),
              ),
              Container(
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: TableCalendar(
                  calendarController: _calendarController,
                  events: widget.currentEvents,
                  initialCalendarFormat: CalendarFormat.week,
                  formatAnimation: FormatAnimation.slide,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableGestures: AvailableGestures.all,
                  availableCalendarFormats: {
                    CalendarFormat.twoWeeks: 'Expand',
                    CalendarFormat.week: 'Week',
                  },
                  calendarStyle: CalendarStyle(
                    markersColor: Colors.brown[700],
                    outsideDaysVisible: false,
                    selectedColor: Colors.deepOrange[400],
                    todayColor: Colors.deepOrange[200],
                    weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle().copyWith(color: Colors.black),
                    weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonTextStyle:
                        TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.deepOrange[400],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  builders: CalendarBuilders(
                    dayBuilder: (context, date, _) {
                      return Container(
                        margin: EdgeInsets.all(2.0),
                        padding: EdgeInsets.only(top: 5.0, left: 6.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        width: 100,
                        height: 100,
                        child: Text('${date.day}', style: TextStyle().copyWith(fontSize: 16.0)),
                      );
                    },
                    selectedDayBuilder: (context, date, _) {
                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                        child: Container(
                          margin: EdgeInsets.all(2.0),
                          padding: EdgeInsets.only(top: 5.0, left: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange[300],
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                          width: 100,
                          height: 100,
                          child: Text('${date.day}', style: TextStyle().copyWith(fontSize: 16.0)),
                        ),
                      );
                    },
                    todayDayBuilder: (context, date, _) {
                      return Container(
                        margin: EdgeInsets.all(2.0),
                        padding: EdgeInsets.only(top: 5.0, left: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        width: 100,
                        height: 100,
                        child: Text('${date.day}', style: TextStyle().copyWith(fontSize: 16.0)),
                      );
                    },
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];
                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 3,
                            bottom: 3,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }
                      return children;
                    },
                  ),
                  onDaySelected: (date, events) {
                    _onDaySelected(date, events);
                    _animationController.forward(from: 0.0);
                  },
                  onVisibleDaysChanged: _onVisibleDaysChanged,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          DefaultTabController(
            length: choices.length,
            child: TabBar(
              onTap: handleTabChanged,
              labelColor: Colors.black,
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              isScrollable: true,
              tabs: choices.map<Widget>((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: choice.icon,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: EventList(
              focusedDay: _calendarController.focusedDay,
              selectedEvents: _selectedEvents,
            ),
          ),
        ],
      ),
    );
  }

  List setDefaultIfAbsent(DateTime eventDate) {
    return widget.userMap.values.map((user) {
      return new UserEvent(
        uid: null,
        user: user,
        dateTime: eventDate,
        status: -1,
        isExpanded: false,
      );
    }).toList();
  }

  void setEventsForSelectedDay() {
    List selectedEvents;
    if (widget.currentEvents.containsKey(_selectedDay)) {
      selectedEvents = widget.currentEvents[_selectedDay];
    } else {
      selectedEvents = setDefaultIfAbsent(_selectedDay);
    }
    if (_selectedFilter != null) {
      selectedEvents = selectedEvents.where((event) => event.status == _selectedFilter).toList();
    }
    selectedEvents.sort((a, b) => a.user.fullName().compareTo(b.user.fullName()));
    setState(() => _selectedEvents = selectedEvents);
  }

  Widget _buildEventsMarker(DateTime date, List<UserEvent> events) {
    final size = events.where((UserEvent event) => event.status > 0).toList().length.toString();
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          size,
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  void handleTabChanged(int index) {
    switch (index) {
      case 0:
        setState(() => _selectedFilter = null);
        break;
      case 1:
        setState(() => _selectedFilter = RED);
        break;
      case 2:
        setState(() => _selectedFilter = YELLOW);
        break;
      case 3:
        setState(() => _selectedFilter = GREEN);
        break;
    }
    setEventsForSelectedDay();
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final Widget icon;
}

List<Choice> choices = <Choice>[
  Choice(title: '- all -', icon: Icon(Icons.remove, color: ICON_COLOR[UNKNOWN])),
  Choice(title: '- off -', icon: Icon(Icons.offline_bolt, color: ICON_COLOR[RED])),
  Choice(title: '- ringl8 -', icon: Icon(Icons.directions_run, color: ICON_COLOR[YELLOW])),
  Choice(title: '- ready -', icon: Icon(Icons.drive_eta, color: ICON_COLOR[GREEN])),
];
