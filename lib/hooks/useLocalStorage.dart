import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A hook that will read and write values to local storage using the SharedPreferences package.
StreamController<String> useLocalStorage(
  String key, {
  String defaultValue,
}) {
  final controller = useStreamController<String>(keys: [key]);

  useEffect(
    () {
      // Listen to the StreamController, and when a value is added, store it using SharedPrefs.
      final sub = controller.stream.listen((data) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(key, data);
      });
      // Unsubscribe when the widget is disposed or on controller/key change
      return sub.cancel;
    },
    [controller, key],
  );

  // Load the initial value from local storage and add it as the initial value to the controller
  useEffect(
    () {
      SharedPreferences.getInstance().then((prefs) async {
        String valueFromStorage = prefs.getString(key);
        controller.add(valueFromStorage ?? defaultValue);
      }).catchError(controller.addError);
      return null;
    },
    [controller, key],
  );

  return controller;
}
