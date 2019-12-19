import 'package:property_change_notifier/property_change_notifier.dart';

// ignore: mixin_inherits_from_not_object
class AppState with PropertyChangeNotifier<String> {
  String _screen = 'group';

  String get screen => _screen;

  set screen(String value) {
    _screen = value;
    notifyListeners('screen');
  }
}
