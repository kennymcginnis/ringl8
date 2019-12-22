import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/validators.dart';
import 'package:ringl8/services/auth.dart';

import 'loding_animation.dart';
import 'styles.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key key}) : super(key: key);

  @override
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  AnimationController _loginButtonController;
  var loading = false;
  final _registerFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  bool showingRegister;

  String firstName;
  String lastName;
  String email = 'kenneth.j.mcginnis@gmail.com';
  String password = 'Millennia@9';
  String error = '';

  @override
  void initState() {
    super.initState();
    showingRegister = false;
    _loginButtonController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Are you sure?'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void handleSubmit() async {
    dynamic result;
    if (showingRegister) {
      if (_registerFormKey.currentState.validate()) {
        setState(() => loading = true);
        _playAnimation();
        result = await _authService.createUserWithEmailAndPassword(
          email,
          password,
        );
      }
    } else {
      if (_loginFormKey.currentState.validate()) {
        setState(() => loading = true);
        _playAnimation();
        result = await _authService.signInWithEmailAndPassword(
          email,
          password,
        );
      }
    }
    if (result == null) {
      setState(() {
        loading = false;
        error = showingRegister
            ? 'Could not register with those credentials'
            : 'Could not sign in with those credentials';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: backgroundImage,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(162, 146, 199, 0.8),
                  Color.fromRGBO(51, 51, 63, 0.9),
                ],
                stops: [0.2, 1.0],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
              ),
            ),
            child: ListView(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        showingRegister ? _buildRegisterForm() : _buildLoginForm(),
                        _buildToggleButton(),
                      ],
                    ),
                    if (loading)
                      StaggerAnimation(buttonController: _loginButtonController.view)
                    else
                      ExtendedButton(
                        text: showingRegister ? 'Register' : 'Sign In',
                        onTap: handleSubmit,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 120.0),
                InputTextField(
                  icon: Icons.mail_outline,
                  initialValue: email,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  onChanged: (value) => setState(() => email = value),
                  validator: Validators.validateEmail,
                ),
                InputTextField(
                  icon: Icons.lock_outline,
                  initialValue: password,
                  labelText: 'Password',
                  obscureText: true,
                  onChanged: (value) => setState(() => password = value),
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRegisterForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0),
                InputTextField(
                  icon: Icons.person,
                  initialValue: firstName,
                  labelText: 'First Name',
                  onChanged: (value) => setState(() => firstName = value),
                  validator: (value) => Validators.validateString(value, 'first name'),
                ),
                SizedBox(height: 10.0),
                InputTextField(
                  icon: Icons.person,
                  initialValue: lastName,
                  labelText: 'Last Name',
                  onChanged: (value) => setState(() => lastName = value),
                  validator: (value) => Validators.validateString(value, 'last name'),
                ),
                SizedBox(height: 10.0),
                InputTextField(
                  icon: Icons.mail_outline,
                  initialValue: email,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  onChanged: (value) => setState(() => email = value),
                  validator: Validators.validateEmail,
                ),
                SizedBox(height: 10.0),
                InputTextField(
                  icon: Icons.lock_outline,
                  initialValue: password,
                  labelText: 'Password',
                  obscureText: true,
                  onChanged: (value) => setState(() => password = value),
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: 20.0),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0))
              ],
            ),
          ),
        ],
      ),
    );
  }

  FlatButton _buildToggleButton() {
    return FlatButton(
      padding: const EdgeInsets.only(
        top: 160.0,
      ),
      onPressed: () => setState(() => showingRegister = !showingRegister),
      child: Text(
        showingRegister ? 'Have an account? Sign In' : 'Don\'t have an account? Sign Up',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
          color: Colors.white,
          fontSize: 17.0,
        ),
      ),
    );
  }
}
