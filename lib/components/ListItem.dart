import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final EdgeInsets margin;
  final double width;
  final String title;
  final String subtitle;
  final DecorationImage image;
  final _dBorderSide = BorderSide(width: 1.0, color: Color.fromRGBO(204, 204, 204, 0.3));

  ListItem({this.margin, this.subtitle, this.title, this.width, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: _dBorderSide,
          bottom: _dBorderSide,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(shape: BoxShape.circle, image: image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
