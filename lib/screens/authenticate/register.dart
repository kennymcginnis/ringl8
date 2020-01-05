import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/application.dart';
import 'package:ringl8/services/auth.dart';
import 'package:ringl8/services/user.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  String _firstName;
  String _lastName;
  String _email = 'kenneth.j.mcginnis@gmail.com';
  String _password = 'Millennia@9';
  String _error = '';

  void handleSubmit() async {

    if (_formKey.currentState.validate()) {
      setState(() => _loading = true);
      User user = await _authService.createUserWithEmailAndPassword(_email, _password);
      if (user == null) {
        setState(() {
          _loading = false;
          _error = 'Could not register with those credentials';
        });
      } else {
        await UserService().updateUser(user.copyWith(
          firstName: _firstName,
          lastName: _lastName,
        ));
        Application.router.navigateTo(context, '/', transition: TransitionType.fadeIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Loading();
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
                initialValue: _firstName,
                labelText: 'First Name',
                onChanged: (value) => setState(() => _firstName = value),
                validator: (value) => Validators.validateString(value, 'first name'),
              ),
              SizedBox(height: 10.0),
              InputTextField(
                icon: Icons.person,
                initialValue: _lastName,
                labelText: 'Last Name',
                onChanged: (value) => setState(() => _lastName = value),
                validator: (value) => Validators.validateString(value, 'last name'),
              ),
              SizedBox(height: 10.0),
              InputTextField(
                icon: Icons.mail_outline,
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                onChanged: (value) => setState(() => _email = value),
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 10.0),
              InputTextField(
                icon: Icons.lock_outline,
                initialValue: _password,
                labelText: 'Password',
                obscureText: true,
                onChanged: (value) => setState(() => _password = value),
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 20.0),
              ExtendedButton(text: 'Sign Up', onTap: handleSubmit),
              Text(_error, style: TextStyle(color: Theme.of(context).errorColor, fontSize: 14.0)),
            ],
          ),
        ),
      ),
    );
  }
}
