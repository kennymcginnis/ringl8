import 'package:flutter/material.dart';
import 'package:ringl8/components/InputTextField.dart';
import 'package:ringl8/components/validators.dart';
import 'package:ringl8/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () {
                widget.toggleView();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                new Container(
                    child: InputTextField(
                        hintText: 'user@domain.com',
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        onChanged: (value) => setState(() => email = value),
                        validator: Validators.validateEmail)),
                new Container(
                    child: InputTextField(
                        hintText: 'P@\$\$W0rd',
                        icon: Icons.lock_outline,
                        labelText: 'Password',
                        obscureText: true,
                        onChanged: (value) => setState(() => password = value),
                        validator: Validators.validatePassword)),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: Text('Register'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _authService
                            .signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() => error =
                              'Could not sign in with those credentials');
                        } else {
                          print('signed in');
                          print(result.uid);
                        }
                      }
                    }),
                SizedBox(height: 12.0),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0))
              ],
            )),
      ),
    );
  }
}
