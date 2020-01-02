import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/helpers/flushbar.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentFirstName;
  String _currentLastName;
  String _currentEmail;
  String _currentAvatar;

  Avataaar _avatar;

  void _randomizeAvatar({String randomizer}) {
    if (randomizer == null || _avatar == null) {
      setState(() {
        _avatar = Avataaar.random();
        _currentAvatar = _avatar.toJson();
      });
    } else {
      setState(() {
        _avatar = Avataaar.random(
          top: randomizer == 'Top' ? null : _avatar.top,
          clothes: randomizer == 'Clothes' ? null : _avatar.clothes,
          eyes: randomizer == 'Eyes' ? null : _avatar.eyes,
          eyebrow: randomizer == 'Eyebrow' ? null : _avatar.eyebrow,
          mouth: randomizer == 'Mouth' ? null : _avatar.mouth,
          skin: randomizer == 'Skin' ? null : _avatar.skin,
          style: randomizer == 'Style' ? null : _avatar.style,
        );
        _currentAvatar = _avatar.toJson();
      });
    }
  }

  List<String> leftRandomizers = ['Top', 'Eyebrow', 'Eyes', 'Mouth'];
  List<String> rightRandomizers = ['Skin', 'Clothes', 'Style'];

  @override
  Widget build(BuildContext context) {
    User _currentUser = Provider.of<User>(context);
    if (_currentUser == null) return Loading();
    _avatar ??=
        _currentUser.avatar == null ? Avataaar.random() : Avataaar.fromJson(_currentUser.avatar);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update your user settings'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              InputTextField(
                icon: Icons.mail_outline,
                initialValue: _currentUser.email,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                onChanged: (value) => setState(() => _currentEmail = value),
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 10.0),
              InputTextField(
                icon: Icons.person,
                initialValue: _currentUser.firstName,
                labelText: 'First Name',
                onChanged: (value) => setState(() => _currentFirstName = value),
                validator: (value) => Validators.validateString(value, 'first name'),
              ),
              SizedBox(height: 10.0),
              InputTextField(
                icon: Icons.person,
                initialValue: _currentUser.lastName,
                labelText: 'Last Name',
                onChanged: (value) => setState(() => _currentLastName = value),
                validator: (value) => Validators.validateString(value, 'last name'),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: leftRandomizers.map((String rand) {
                      return FlatButton(
                        onPressed: () => _randomizeAvatar(randomizer: rand),
                        child: Text(rand),
                      );
                    }).toList(),
                  ),
                  Column(
                    children: <Widget>[
                      AvataaarImage(
                        avatar: _avatar,
                        errorImage: Icon(Icons.error),
                        placeholder: CircularProgressIndicator(),
                        width: 128.0,
                      ),
                    ],
                  ),
                  Column(
                    children: rightRandomizers.map((String rand) {
                      return FlatButton(
                        onPressed: () => _randomizeAvatar(randomizer: rand),
                        child: Text(rand),
                      );
                    }).toList(),
                  ),
                ],
              ),
              IconButton(
                iconSize: 48.0,
                icon: Icon(Icons.refresh),
                onPressed: _randomizeAvatar,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(25),
        child: ExtendedButton(
          text: 'Update',
          onTap: () async {
            if (_formKey.currentState.validate()) {
              try {
                await UserService().updateUser(
                  _currentUser.copyWith(
                    User(
                      firstName: _currentFirstName,
                      lastName: _currentLastName,
                      email: _currentEmail,
                      avatar: _currentAvatar,
                    ),
                  ),
                );
                FlushbarHelper(context, 'success', 'User settings updated.').show();
              } catch (e) {
                FlushbarHelper(context, 'error', e.toString()).show();
              }
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
