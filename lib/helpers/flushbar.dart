import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  final BuildContext context;
  final String status;
  final String message;

  FlushbarHelper(this.context, this.status, this.message);

  IconData icon;
  MaterialColor color;

  show() {
    switch (status) {
      case 'success':
        color = Colors.green;
        icon = Icons.check;
        break;
      case 'error':
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
