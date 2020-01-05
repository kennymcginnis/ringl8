import 'package:fluro/fluro.dart';
import 'package:ringl8/routes/route_handlers.dart';

class Routes {
  static String root = '/';
  static String today = '/today';
  static String groups = '/groups';
  static String group = '/group';
  static String customize = '/customize';
  static String members = '/members';
  static String chat = '/chat';
  static String calendar = '/calendar';
  static String invitations = '/groups';
  static String settings = '/settings';
  static String logout = '/logout';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (context, _) {
      print("ROUTE WAS NOT FOUND!!!");
      return null;
    });
    router.define(root, handler: authHandler);
    router.define(today, handler: calendarHandler(true));
    router.define(group, handler: groupHandler);
    router.define(customize, handler: customizeHandler);
    router.define(members, handler: membersHandler);
    router.define(groups, handler: groupsHandler);
    router.define(chat, handler: chatHandler);
    router.define(calendar, handler: calendarHandler(false));
    router.define(settings, handler: settingsHandler);
    router.define(logout, handler: logoutHandler);
  }
}
