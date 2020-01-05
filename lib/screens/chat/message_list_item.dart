import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/routes/app_state.dart';

class MessageListItem extends StatelessWidget {
  final DocumentSnapshot messageSnapshot;
  final application = sl.get<AppState>();
  final Animation animation;

  MessageListItem({this.messageSnapshot, this.animation});

  @override
  Widget build(BuildContext context) {
    Map<String, User> _userMap = Provider.of<Map<String, User>>(context);
    if (_userMap.isEmpty) return Loading();
    String senderUID = messageSnapshot.data['senderUID'];
    User sender = _userMap[senderUID];
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: application.currentUserUID == senderUID
              ? getSentMessageLayout(sender)
              : getReceivedMessageLayout(sender),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout(User sender) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              sender.fullName(),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                messageSnapshot.data['text'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 0.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade800,
              child: Text(
                sender.initials(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout(User sender) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 20.0, 5.0, 0.0),
            child: CircleAvatar(
              backgroundColor: Colors.black87,
              child: Text(
                sender.initials(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sender.fullName(),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                messageSnapshot.data['text'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
