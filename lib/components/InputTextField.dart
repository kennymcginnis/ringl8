import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final double _bottomMargin;
  final TextStyle _hintStyle;
  final String _hintText;
  final IconData _icon;
  final Color _iconColor;
  final TextInputType _keyboardType;
  final String _labelText;
  final bool _obscureText;
  final Function _onChanged;
  final Color _textFieldColor;
  final TextStyle _textStyle;
  final Function _validator;

  static Color _dColor = Color.fromRGBO(255, 255, 255, 0.4);
  static Color _dTextFieldColor = Color.fromRGBO(0, 0, 0, 0.7);

  static TextStyle _dTextStyle = new TextStyle(
      color: _dColor, fontSize: 16.0, fontWeight: FontWeight.normal);

  InputTextField({
    bottomMargin,
    hintStyle,
    hintText,
    icon,
    iconColor,
    keyboardType,
    labelText,
    obscureText,
    onChanged,
    textFieldColor,
    textStyle,
    validator,
  })  : _bottomMargin = bottomMargin ?? 20.0,
        _hintStyle = hintStyle ?? _dTextStyle,
        _hintText = hintText,
        _icon = icon,
        _iconColor = iconColor ?? _dColor,
        _keyboardType = keyboardType,
        _labelText = labelText,
        _obscureText = obscureText ?? false,
        _onChanged = onChanged,
        _textFieldColor = textFieldColor ?? _dTextFieldColor,
        _textStyle = textStyle ?? _dTextStyle,
        _validator = validator;

  @override
  Widget build(BuildContext context) {
    return (new Container(
        margin: new EdgeInsets.only(bottom: _bottomMargin),
        child: new DecoratedBox(
          decoration: new BoxDecoration(
//              borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
              color: _textFieldColor),
          child: new TextFormField(
            keyboardType: _keyboardType,
            obscureText: _obscureText,
            onChanged: _onChanged,
            style: _textStyle,
            validator: _validator,
            decoration: new InputDecoration(
                hintText: _hintText,
                hintStyle: _hintStyle,
                prefixIcon: new Icon(
//                hideDivider: true,
                  _icon,
                  color: _iconColor,
                ),
                labelText: _labelText),
          ),
        )));
  }
}
