import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/extended_button.dart';
import 'package:ringl8/components/input_text_field.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/components/user_avatar.dart';
import 'package:ringl8/helpers/avatar_helpers.dart';
import 'package:ringl8/helpers/flushbar.dart';
import 'package:ringl8/helpers/validators.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/models/user_group.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final String selectedUrl = 'https://getavataaars.com/';

  User _currentUser;
  String _currentFirstName;
  String _currentLastName;
  String _currentEmail;

  Avataaar _avatar;

  List<String> randomizers = ['Top', 'Eyebrow', 'Eyes', 'Mouth', 'Skin', 'Clothes', 'Style'];

  final List<Choice> choices = <Choice>[
    Choice(title: 'Contact Details', icon: Icon(Icons.group)),
    Choice(title: 'Customize Avatar', icon: Icon(Icons.person_add)),
  ];

  @override
  Widget build(BuildContext context) {
    _currentUser = Provider.of<User>(context);
    if (_currentUser == null) return Loading();
    _avatar ??=
        _currentUser.avatar == null ? Avataaar.random() : Avataaar.fromJson(_currentUser.avatar);
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update your user settings'),
          elevation: 0.0,
          bottom: TabBar(
            isScrollable: true,
            tabs: choices
                .map<Widget>((Choice choice) => Tab(text: choice.title, icon: choice.icon))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: [
            _buildDetailsForm(),
            _buildCustomAvatar(),
          ],
        ),
      ),
    );
  }

  void _updateSettings() async {
    if (_formKey.currentState.validate()) {
      try {
        List<UserGroup> groups = new List<UserGroup>();
        groups.add(new UserGroup(group: '536eeU8PdCsipwAtaIFA'));
        groups.add(new UserGroup(group: 'HldJQbFNBFAm2Nu4daTc'));
        await UserService().updateGroups(groups);

//        await UserService().updateUser(
//          _currentUser.copyWith(
//            firstName: _currentFirstName,
//            lastName: _currentLastName,
//            email: _currentEmail,
//            groups: groups
//          ),
//        );
        FlushbarHelper(context, Status.success, 'User settings updated.').show();
      } catch (e) {
        FlushbarHelper(context, Status.error, e.toString()).show();
      }
      Navigator.pop(context);
    }
  }

  void _updateAvatar() async {
    try {
      await UserService().updateUser(_currentUser.copyWith(avatar: _avatar.toJson()));
      FlushbarHelper(context, Status.success, 'User settings updated.').show();
    } catch (e) {
      FlushbarHelper(context, Status.error, e.toString()).show();
    }
    Navigator.pop(context);
  }

  void _randomizeAvatar({String randomizer}) {
    if (randomizer == null || _avatar == null) {
      setState(() {
        _avatar = Avataaar.random();
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
      });
    }
  }

  Widget _buildDetailsForm() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
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
                    )
                  ],
                ),
              ),
            ),
            ExtendedButton(text: 'Update Contact', onTap: () => _updateSettings()),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAvatar() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: randomizers.map((String rand) {
                        return FlatButton(
                          onPressed: () => _randomizeAvatar(randomizer: rand),
                          child: Text(rand),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        UserAvatar(avataaar: _avatar),
                        IconButton(
                          iconSize: 48.0,
                          icon: Icon(Icons.refresh),
                          onPressed: _randomizeAvatar,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Or paste the complete url from getavataaars.com here:'),
          ),
          InputTextField(
            keyboardType: TextInputType.url,
            icon: Icons.person,
            labelText: selectedUrl,
            onChanged: (value) {
              setState(() {
                _avatar = AvatarHelpers.avatarFromAvataaarsUrl(value);
              });
            },
          ),
          ExtendedButton(text: 'Update Avatar', onTap: () => _updateAvatar()),
        ],
      ),
    );
  }
}
