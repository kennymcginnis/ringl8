import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final double _bottomMargin;
  final TextStyle _hintStyle;
  final String _hintText;
  final IconData _icon;
  final Color _iconColor;
  final String _initialValue;
  final TextInputType _keyboardType;
  final String _labelText;
  final TextStyle _labelStyle;
  final bool _obscureText;
  final Function _onChanged;
  final Color _textFieldColor;
  final TextStyle _textStyle;
  final Function _validator;

  static Color _dColor = Colors.white;
  static Color _dTextFieldColor = Color.fromRGBO(0, 0, 0, 0.7);

  static TextStyle _dTextStyle =
      new TextStyle(color: _dColor, fontSize: 16.0, fontWeight: FontWeight.normal);

  InputTextField({
    bottomMargin,
    hintStyle,
    hintText,
    icon,
    iconColor,
    initialValue,
    keyboardType,
    labelText,
    labelStyle,
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
        _initialValue = initialValue,
        _keyboardType = keyboardType,
        _labelText = labelText,
        _labelStyle = labelStyle ?? _dTextStyle,
        _obscureText = obscureText ?? false,
        _onChanged = onChanged,
        _textFieldColor = textFieldColor ?? _dTextFieldColor,
        _textStyle = textStyle ?? _dTextStyle,
        _validator = validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: _bottomMargin),
      child: TextFormField(
        initialValue: _initialValue,
        keyboardType: _keyboardType,
        obscureText: _obscureText,
        onChanged: _onChanged,
        style: _textStyle,
        validator: _validator,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          hintText: _hintText,
          hintStyle: _hintStyle,
          prefixIcon: Icon(_icon, color: _iconColor),
          labelText: _labelText,
          labelStyle: _labelStyle,
        ),
      ),
    );
  }
}
