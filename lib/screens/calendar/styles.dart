import 'package:flutter/material.dart';

const String ICONS = 'icons';
const String CLOSED = 'closed';
const String OPEN = 'open';
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

final Map<int, DecorationImage> months = {
  DateTime.january: new DecorationImage(
    image: new ExactAssetImage('assets/months/01-january.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.february: new DecorationImage(
    image: new ExactAssetImage('assets/months/02-february.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.march: new DecorationImage(
    image: new ExactAssetImage('assets/months/03-march.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.april: new DecorationImage(
    image: new ExactAssetImage('assets/months/04-april.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.may: new DecorationImage(
    image: new ExactAssetImage('assets/months/05-may.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.june: new DecorationImage(
    image: new ExactAssetImage('assets/months/06-june.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.july: new DecorationImage(
    image: new ExactAssetImage('assets/months/07-july.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.august: new DecorationImage(
    image: new ExactAssetImage('assets/months/08-august.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.september: new DecorationImage(
    image: new ExactAssetImage('assets/months/09-september.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.october: new DecorationImage(
    image: new ExactAssetImage('assets/months/10-october.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.november: new DecorationImage(
    image: new ExactAssetImage('assets/months/11-november.jpg'),
    fit: BoxFit.cover,
  ),
  DateTime.december: new DecorationImage(
    image: new ExactAssetImage('assets/months/12-december.jpg'),
    fit: BoxFit.cover,
  ),
};
