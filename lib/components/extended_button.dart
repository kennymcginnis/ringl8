import 'package:flutter/material.dart';

class ExtendedButton extends StatelessWidget {
  final String text;
  final Function onTap;

  ExtendedButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 320.0,
          height: 60.0,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
