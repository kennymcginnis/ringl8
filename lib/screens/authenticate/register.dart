import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/services/auth.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String firstName;
  String lastName;
  String email = 'kenneth.j.mcginnis@gmail.com';
  String password = 'Millennia@9';
  String error = '';

  void handleSubmit() async {
    dynamic result;
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      result = await _authService.createUserWithEmailAndPassword(
        email,
        password,
      );
    }
    if (result == null) {
      setState(() {
        loading = false;
        error = 'Could not register with those credentials';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Loading();
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0),
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
              ExtendedButton(text: 'Sign Up', onTap: handleSubmit),
              Text(error, style: TextStyle(color: Theme.of(context).errorColor, fontSize: 14.0)),
            ],
          ),
        ),
      ),
    );
  }
}
