import 'package:flutter/material.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/components/validators.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/auth.dart';
import 'package:ringl8/services/user.dart';

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
  String firstName = '';
  String lastName = '';
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
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              InputTextField(
                icon: Icons.person,
                labelText: 'First Name',
                onChanged: (value) => setState(() => firstName = value),
                validator: (value) =>
                    Validators.validateString(value, 'first name'),
              ),
              InputTextField(
                icon: Icons.person,
                labelText: 'Last Name',
                onChanged: (value) => setState(() => lastName = value),
                validator: (value) =>
                    Validators.validateString(value, 'last name'),
              ),
              InputTextField(
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                onChanged: (value) => setState(() => email = value),
                validator: Validators.validateEmail,
              ),
              InputTextField(
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
                    User user = await _authService
                        .createUserWithEmailAndPassword(email, password);
                    if (user == null) {
                      setState(() {
                        loading = false;
                        error = 'There was an error registering $email';
                      });
                    } else {
                      await UserService(uid: user.uid).updateUser(User.clone(
                        user,
                        firstName: firstName,
                        lastName: lastName,
                      ));
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0))
            ],
          ),
        ),
      ),
    );
  }
}
