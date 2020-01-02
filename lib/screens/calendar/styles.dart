import 'package:flutter/material.dart';

const int UNKNOWN = -1;
const int RED = 0;
const int YELLOW = 1;
const int GREEN = 2;

final Map<int, Color> ICON_COLOR = {
  UNKNOWN: Colors.grey[700],
  RED: Colors.red[800],
  YELLOW: Colors.yellow,
  GREEN: Colors.green[900],
};

final Map<int, IconData> ICON = {
  UNKNOWN: Icons.remove,
  RED: Icons.offline_bolt,
  YELLOW: Icons.directions_run,
  GREEN: Icons.drive_eta,
};
