import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:ringl8/components/InputTextField.dart';
import 'package:ringl8/screens/login/sign_in_button.dart';
import 'package:ringl8/components/SignUpLink.dart';
import 'package:ringl8/components/Validators.dart';
import 'package:ringl8/services/auth.dart';

import 'login_animation.dart';
import 'styles.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> with TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  AnimationController _loginButtonController;
  var animationStatus = false;
  final _formKey = GlobalKey<FormState>();

  String email = 'kenneth.j.mcginnis@gmail.com';
  String password = 'Millennia@9';
  String error = '';

  @override
  void initState() {
    super.initState();
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
                onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
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
                        formContainer(),
                        SignUp(),
                      ],
                    ),
                    if (animationStatus)
                      StaggerAnimation(
                        buttonController: _loginButtonController.view,
                      )
                    else
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => animationStatus = true);
                              dynamic result =
                                  await _authService.signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  animationStatus = false;
                                  error = 'Could not sign in with those credentials';
                                });
                              } else {
                                _playAnimation();
                                print('signed in');
                                print(result.uid);
                              }
                            }
                          },
                          child: SignInButton(),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container formContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            key: _formKey,
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
}
