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
    fontWeight: FontWeight.normal,
  );

  static final appTheme = new ThemeData(
    hintColor: Colors.white,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static final facebook_icon = IconData(0xea94, fontFamily: 'icon');
}

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/home.jpeg'),
  fit: BoxFit.cover,
);

DecorationImage profileImage = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/default-avatar.jpg'),
  fit: BoxFit.cover,
);

DecorationImage timelineImage = new DecorationImage(
  image: new ExactAssetImage('assets/timeline.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar1 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-1.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar2 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-2.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar3 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-3.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar4 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-4.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar5 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-5.jpg'),
  fit: BoxFit.cover,
);
DecorationImage avatar6 = new DecorationImage(
  image: new ExactAssetImage('assets/avatars/avatar-6.jpg'),
  fit: BoxFit.cover,
);

// DecorationImage profileImage = new DecorationImage(
//   image: new ExactAssetImage('assets/avatars/avatar-7.gif'),
//   fit: BoxFit.cover,
// );
