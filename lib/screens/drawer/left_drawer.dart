import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:ringl8/models/app_state.dart';

class LeftDrawer extends StatelessWidget {
  final double _dragUpdate;

  LeftDrawer(this._dragUpdate);

  @override
  Widget build(BuildContext context) {
    final appState = PropertyChangeProvider.of<AppState>(context, listen: false).value;

    void switchScreen(String screen) {
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      appState.screen = screen;
    }

    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                //stops: [0.1, 0.5,0.5, 0.7, 0.9],
                colors: [
                  ColorTween(
                    begin: Colors.blueAccent,
                    end: Colors.blueGrey[200],
                  ).lerp(_dragUpdate),
                  ColorTween(
                    begin: Colors.grey,
                    end: Colors.blueGrey[800],
                  ).lerp(_dragUpdate),
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10, bottom: 15),
                            width: 80,
                            child: ClipRRect(
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrWfWLnxIT5TnuE-JViLzLuro9IID2d7QEc2sRPTRoGWpgJV75",
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Text(
                            "User",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                        //mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      ListTile(
                        onTap: () => switchScreen('users'),
                        title: Text(
                          "User List",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.dashboard,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        onTap: () => switchScreen('group'),
                        title: Text(
                          "Group Status",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.rounded_corner,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        onTap: () => switchScreen('chat'),
                        title: Text(
                          "Chat",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.bookmark_border,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Close Friends",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.list,
                          size: 22,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Suggested People",
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Icon(
                          Icons.person_add,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.all_out,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Text(
                          " Log Out",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          _dragUpdate < 1
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: (10 - _dragUpdate * 10),
                    sigmaY: (10 - _dragUpdate * 10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                )
              : null,
        ].where((a) => a != null).toList(),
      ),
    );
  }
}
