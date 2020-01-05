import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum Status { success, error }

class FlushbarHelper {
  final BuildContext context;
  final Status status;
  final String message;

  FlushbarHelper(this.context, this.status, this.message);

  IconData icon;
  MaterialColor color;

  show() {
    switch (status) {
      case Status.success:
        color = Colors.green;
        icon = Icons.check;
        break;
      case Status.error:
        color = Colors.red;
        icon = Icons.info_outline;
        break;
    }
    Flushbar(
      message: message,
      icon: Icon(icon, size: 28.0, color: color),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: color,
    )..show(context);
  }
}
