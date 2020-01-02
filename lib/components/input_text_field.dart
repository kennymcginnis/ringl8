import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final double bottomMargin;
  final String hintText;
  final IconData icon;
  final Color iconColor;
  final String initialValue;
  final TextInputType keyboardType;
  final String labelText;
  final int maxLength;
  final bool obscureText;
  final Function onChanged;
  final Color textFieldColor;
  final Function validator;

  static Color dColor = Colors.white;
  static Color dTextFieldColor = Color.fromRGBO(0, 0, 0, 0.7);

  static TextStyle dTextStyle =
      new TextStyle(color: dColor, fontSize: 16.0, fontWeight: FontWeight.normal);

  InputTextField({
    this.bottomMargin,
    this.hintText,
    this.icon,
    this.iconColor,
    this.initialValue,
    this.keyboardType,
    this.labelText,
    this.maxLength,
    this.obscureText,
    this.onChanged,
    this.textFieldColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin ?? 20.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        onChanged: onChanged ?? () => {},
        validator: validator,
        maxLength: maxLength,
        decoration: InputDecoration(
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
          focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedErrorBorder,
          errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
          hintText: hintText,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          prefixIcon: Icon(icon),
          labelText: labelText,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
      ),
    );
  }
}
