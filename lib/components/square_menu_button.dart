import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ringl8/routes/application.dart';

class SquareMenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final String navigateTo;

  SquareMenuButton({this.icon, this.text, this.navigateTo});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        child: FlatButton(
          color: theme.cardColor,
          highlightColor: theme.highlightColor,
          splashColor: theme.splashColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 36),
              SizedBox(height: 10.0),
              Text(text, textAlign: TextAlign.center),
            ],
          ),
          onPressed: () => Application.router.navigateTo(
            context,
            navigateTo,
            transition: TransitionType.fadeIn,
          ),
        ),
      ),
    );
  }
}
