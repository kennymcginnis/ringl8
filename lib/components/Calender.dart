import 'package:flutter/material.dart';
import 'package:ringl8/components/CalenderCell.dart';

class Calender extends StatelessWidget {
  final EdgeInsets margin;
  final List<String> week = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  final List arrayDay = [];

  Calender({this.margin});

  int totalDays(int month) {
    if (month == 2)
      return (28);
    else if (month == 4 || month == 6 || month == 9 || month == 11)
      return (30);
    else
      return (31);
  }

  @override
  Widget build(BuildContext context) {
    int element = new DateTime.now().day - new DateTime.now().weekday;
    int totalDay = totalDays(new DateTime.now().month);
    for (var i = 0; i < 7; i++) {
      if (element > totalDay) element = 1;
      arrayDay.add(element);
      element++;
    }
    var i = -1;
    return Container(
      margin: margin,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(204, 204, 204, 1.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: week.map((String week) {
          ++i;
          return CalenderCell(
            week: week,
            day: arrayDay[i].toString(),
            today: arrayDay[i] != new DateTime.now().day ? false : true,
          );
        }).toList(),
      ),
    );
  }
}
