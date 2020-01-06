import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/models/user_event.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/screens/calendar/event_list.dart';
import 'package:ringl8/screens/calendar/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final bool showListOnly;

  const CalendarView({Key key, this.showListOnly}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  final application = sl.get<AppState>();
  final formatter = new DateFormat('yyyy-MM-dd');

  DateTime _selectedDay;
  int _selectedFilter;
  List _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.parse(formatter.format(DateTime.now()));

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

  List<Choice> choices = <Choice>[
    Choice(title: '- All -', icon: Icon(Icons.remove, color: ICON_COLOR[UNKNOWN])),
    Choice(title: '- Off -', icon: Icon(Icons.offline_bolt, color: ICON_COLOR[RED])),
    Choice(title: '- ringl8 -', icon: Icon(Icons.directions_run, color: ICON_COLOR[YELLOW])),
    Choice(title: '- Ready -', icon: Icon(Icons.drive_eta, color: ICON_COLOR[GREEN])),
  ];

  Map<String, User> _userMap;
  List<Event> _streamedEvents;
  Map<DateTime, List> _currentEvents;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    _userMap = Provider.of<Map<String, User>>(context);
    _streamedEvents = Provider.of<List<Event>>(context);
    if (_userMap == null || _streamedEvents == null) return Loading();

    _currentEvents = _buildEventDataFromStream();
    _selectedEvents = setEventsForSelectedDay();

    return Scaffold(
      appBar: AppBar(
        title: Text(application.currentGroup.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          widget.showListOnly
              ? Container(width: 0, height: 0)
              : Container(
                  color: theme.primaryColor,
                  child: TableCalendar(
                    calendarController: _calendarController,
                    events: _currentEvents,
                    initialCalendarFormat: CalendarFormat.twoWeeks,
                    formatAnimation: FormatAnimation.slide,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    availableGestures: AvailableGestures.all,
                    availableCalendarFormats: {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.twoWeeks: 'Expand',
                      CalendarFormat.week: 'Week',
                    },
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: true,
                      selectedColor: theme.textSelectionColor,
                      weekendStyle: TextStyle().copyWith(color: theme.buttonColor),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle:
                          TextStyle().copyWith(fontSize: 15.0, color: theme.primaryColorLight),
                      weekendStyle: TextStyle().copyWith(fontSize: 15.0, color: theme.buttonColor),
                    ),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      headerMargin: EdgeInsets.symmetric(vertical: 5),
                      titleTextStyle: TextStyle(fontSize: 19.0),
                      leftChevronIcon: Icon(Icons.chevron_left, color: theme.primaryColorLight),
                      rightChevronIcon: Icon(Icons.chevron_right, color: theme.primaryColorLight),
                      formatButtonTextStyle: TextStyle(fontSize: 15.0, color: theme.primaryColor),
                      formatButtonDecoration: BoxDecoration(
                        color: theme.accentColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    builders: CalendarBuilders(
                      dayBuilder: (context, date, _) => Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('${date.day}', textAlign: TextAlign.center),
                      ),
                      selectedDayBuilder: (context, date, _) => FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.only(top: 8.0),
                          color: theme.cardColor,
                          child: Text('${date.day}', textAlign: TextAlign.center),
                        ),
                      ),
                      outsideDayBuilder: (context, date, _) => Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${date.day}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.disabledColor),
                        ),
                      ),
                      outsideWeekendDayBuilder: (context, date, _) => Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${date.day}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.disabledColor),
                        ),
                      ),
                      markersBuilder: (context, date, events, holidays) {
                        final children = <Widget>[];
                        if (events.isNotEmpty) {
                          children
                              .add(Positioned(top: 24, child: _buildEventsMarker(date, events)));
                        }
                        return children;
                      },
                    ),
                    onDaySelected: (date, events) {
                      _onDaySelected(date, events);
                      _animationController.forward(from: 0.0);
                    },
                  ),
                ),
          DefaultTabController(
            length: choices.length,
            child: TabBar(
              onTap: handleTabChanged,
              isScrollable: true,
              tabs: choices
                  .map<Widget>((Choice choice) => Tab(
                        text: choice.title,
                        icon: choice.icon,
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: EventList(
              showListOnly: widget.showListOnly,
              selectedDay: _selectedDay,
              selectedEvents: _selectedEvents,
            ),
          ),
        ],
      ),
    );
  }

  List setDefaultIfAbsent(DateTime eventDate) {
    return _userMap.values.map((user) {
      return new UserEvent(
        uid: null,
        user: user,
        dateTime: eventDate,
        status: -1,
        isExpanded: false,
      );
    }).toList();
  }

  List setEventsForSelectedDay() {
    List selectedEvents;
    if (_currentEvents.containsKey(_selectedDay)) {
      selectedEvents = _currentEvents[_selectedDay];
    } else {
      selectedEvents = setDefaultIfAbsent(_selectedDay);
    }
    if (_selectedFilter != null) {
      selectedEvents = selectedEvents.where((event) => event.status == _selectedFilter).toList();
    }
    selectedEvents.sort((a, b) => a.user.fullName().compareTo(b.user.fullName()));
    return selectedEvents;
  }

  Widget _buildEventsMarker(DateTime date, List<UserEvent> events) {
    var map = {UNKNOWN: 0, RED: 0, YELLOW: 0, GREEN: 0};
    final size = events.length;
    events.forEach((UserEvent e) => map.update(e.status, (x) => x + 1));
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [RED, YELLOW, GREEN]
            .map((status) => Container(
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ICON_COLOR[status],
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  width: 50.0 * (map[status] / size),
                  height: 5.0,
                ))
            .toList());
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
    _selectedEvents = setEventsForSelectedDay();
  }

  Map<DateTime, List> _buildEventDataFromStream() {
    Map<DateTime, List> mapOutput = new Map<DateTime, List>();
    if (_streamedEvents.isEmpty) return {};
    _streamedEvents.forEach((event) {
      DateTime eventDateTime = DateTime.parse(event.dateTime);
      List defaults = setDefaultIfAbsent(eventDateTime);
      mapOutput.putIfAbsent(eventDateTime, () => defaults.toList());

      UserEvent userEvent =
          mapOutput[eventDateTime].firstWhere((userEvent) => userEvent.user.uid == event.userUID);
      userEvent.uid = event.uid;
      userEvent.status = event.status;
    });
    return mapOutput;
  }
}
