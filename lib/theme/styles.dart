import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;
  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('666666');
  static final String _fontNameDefault = 'Muli';

  static final navBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
  );
  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );
  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static final textStyle = new TextStyle(
      color: const Color.fromRGBO(0, 0, 0, 0.9),
      fontSize: 16.0,
      fontWeight: FontWeight.normal
  );

  static final appTheme = new ThemeData(
    hintColor: Colors.white,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static final facebook_icon = IconData(0xea94, fontFamily: 'icon');
}
