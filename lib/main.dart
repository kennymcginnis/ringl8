import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/listeners/authentication.dart';
import 'package:ringl8/models/app_state.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/auth.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Inner Drawer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          backgroundColor: Colors.white,
        ),
        home: Scaffold(
          body: PropertyChangeProvider(
            value: appState,
            child: AuthListener(),
          ),
        ),
      ),
    );
  }
}
