import 'package:flutter/material.dart';

class CalenderCell extends StatelessWidget {
  final String week;
  final String day;
  final bool today;

  CalenderCell({this.week, this.day, this.today});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          week,
          style: TextStyle(
            color: Color.fromRGBO(204, 204, 204, 1.0),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Container(
            width: 35.0,
            height: 35.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: today ? Color.fromRGBO(204, 204, 204, 0.3) : Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (today)
                  Container(
                    padding: EdgeInsets.only(top: 3.0),
                    width: 3.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
        )
      ],
    );
  }
}
