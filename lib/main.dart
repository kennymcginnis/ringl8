import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/application.dart';
import 'package:ringl8/routes/routes.dart';
import 'package:ringl8/services/auth.dart';
import 'package:ringl8/theme/theme.dart';

void main() => initializeDateFormatting().then((_) => runApp(AppComponent()));

class AppComponent extends HookWidget {
  AppComponent() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
//    return HookBuilder(
//      builder: (context) {
//        AsyncSnapshot<String> localStorageStream =
//            useStream(useLocalStorage('currentGroup').stream);
//        if (localStorageStream.hasData) {
//          Application.currentGroupUID = localStorageStream.data;
//        }
    return StreamBuilder<User>(
      stream: AuthService().user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (!snapshot.hasData) return Loading();
        Application.currentUserUID = snapshot.data.uid;
        return MaterialApp(
          title: 'ringl8',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          onGenerateRoute: Application.router.generator,
        );
      },
    );
//      },
//    );
  }
}
