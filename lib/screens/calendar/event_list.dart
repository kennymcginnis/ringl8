import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ringl8/components/folding_cell.dart';
import 'package:ringl8/components/user_avatar.dart';
import 'package:ringl8/models/event.dart';
import 'package:ringl8/models/user_event.dart';
import 'package:ringl8/services/event.dart';

import 'styles.dart';

class EventList extends StatelessWidget {
  final selectedDay;
  final selectedEvents;
  final showListOnly;

  EventList({
    this.selectedDay,
    this.selectedEvents,
    this.showListOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          UserEvent selectedEvent = selectedEvents[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: FoldingCell(
              unfoldCell: selectedEvent.isExpanded,
              frontWidget: _buildFrontWidget(context, index),
              innerTopWidget: _buildInnerTopWidget(index),
              innerBottomWidget: _buildInnerBottomWidget(index),
              cellSize: Size(MediaQuery.of(context).size.width, 65),
              padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
              borderRadius: 6,
              animationDuration: Duration(milliseconds: 300),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontWidget(BuildContext context, int index) {
    return Builder(
      builder: (BuildContext context) {
        UserEvent selectedEvent = selectedEvents[index];
        FoldingCellState foldingCellState = context.findAncestorStateOfType<FoldingCellState>();
        return GestureDetector(
          onTap: () => foldingCellState?.toggleFold(),
          child: Container(
            color: Theme.of(context).cardColor,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: UserAvatar(user: selectedEvent.user, size: AvatarSize.small),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        selectedEvent.user.fullName(),
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      showListOnly
                          ? Container(width: 0, height: 0)
                          : Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                selectedEvent.user.email,
                                style: TextStyle(color: Theme.of(context).disabledColor),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 42,
                    height: 42,
                    child: FloatingActionButton(
                      heroTag: 'current$index',
                      onPressed: () => foldingCellState?.toggleFold(),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: ICON_COLOR[selectedEvent.status],
                      child: Icon(ICON[selectedEvent.status], size: 26.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerTopWidget(int index) {
    return Builder(
      builder: (BuildContext context) {
        UserEvent selectedEvent = selectedEvents[index];
        return GestureDetector(
          onTap: () {
            FoldingCellState foldingCellState = context.findAncestorStateOfType<FoldingCellState>();
            foldingCellState?.toggleFold();
          },
          child: Container(
            color: ICON_COLOR[selectedEvent.status],
            alignment: Alignment.center,
            child: Text(
              selectedEvent.user.fullName(),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerBottomWidget(int index) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          FoldingCellState foldingCellState = context.findAncestorStateOfType<FoldingCellState>();
          foldingCellState?.toggleFold();
        },
        child: Container(
          color: Colors.grey,
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: _buildFloatingActionBar(index),
          ),
        ),
      );
    });
  }

  Widget _buildFloatingActionBar(int index) {
    return Container(
      height: 48.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 16.0, width: 5.0),
          _buildFloatingActionButton(index, UNKNOWN),
          SizedBox(height: 16.0, width: 75.0),
          _buildFloatingActionButton(index, RED),
          _buildFloatingActionButton(index, YELLOW),
          _buildFloatingActionButton(index, GREEN),
          SizedBox(height: 16.0, width: 5.0),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(int index, int status) {
    final formatter = new DateFormat('yyyy-MM-dd');
    UserEvent selectedEvent = selectedEvents[index];
    return Builder(builder: (context) {
      return FloatingActionButton(
        heroTag: 'setStatus$index$status',
        onPressed: () {
          EventService(uid: selectedEvent.uid).updateEvent(new Event(
            userUID: selectedEvent.user.uid,
            status: status,
            dateTime: formatter.format(selectedDay),
          ));
          FoldingCellState foldingCellState = context.findAncestorStateOfType<FoldingCellState>();
          foldingCellState?.toggleFold();
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: ICON_COLOR[status],
        child: Icon(ICON[status], size: 32.0),
      );
    });
  }
}
