import 'package:flutter/material.dart';
import 'package:ringl8/screens/drawer/drawers.dart';
import 'package:ringl8/screens/login/login.dart';

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: "Dribbble Animation App",
      debugShowCheckedModeBanner: false,
      home: new Login(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new Login(),
              settings: settings,
            );
          case '/home':
            return new MyCustomRoute(
              builder: (_) => new Drawers(),
              settings: settings,
            );
          default:
            return null;
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}