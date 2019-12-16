import 'package:flutter/material.dart';
import 'package:ringl8/components/InputTextField.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/components/validators.dart';
import 'package:ringl8/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
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
                InputTextField(
                  hintText: 'Email',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  onChanged: (value) => setState(() => email = value),
                  validator: Validators.validateEmail,
                ),
                InputTextField(
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  labelText: 'Password',
                  obscureText: true,
                  onChanged: (value) => setState(() => password = value),
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: Text('Register'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _authService
                            .createUserWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'There was an error registering $email';
                          });
                        } else {
                          print('registered');
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
