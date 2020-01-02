import 'package:flutter/material.dart';

class ExtendedButton extends StatelessWidget {
  final String text;
  final Function onTap;

  ExtendedButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 320.0,
        height: 60.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Text(text, style: TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
