import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ringl8/models/choice.dart';
import 'package:ringl8/screens/authenticate/login.dart';
import 'package:ringl8/screens/authenticate/register.dart';

class AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Choice> _choices = <Choice>[
      Choice(title: '- Existing -', icon: Icon(FontAwesomeIcons.doorOpen)),
      Choice(title: '- New User -', icon: Icon(FontAwesomeIcons.userPlus)),
    ];
    return DefaultTabController(
      length: _choices.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          bottom: TabBar(
            isScrollable: true,
            tabs: _choices
                .map<Widget>((choice) => Tab(text: choice.title, icon: choice.icon))
                .toList(),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            TabBarView(
              children: [
                LoginForm(),
                RegisterForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
