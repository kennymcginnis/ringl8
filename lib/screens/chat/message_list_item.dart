import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/user.dart';

var currentUserEmail;

class MessageListItem extends StatelessWidget {
  final DocumentSnapshot messageSnapshot;
  final Animation animation;

  MessageListItem({this.messageSnapshot, this.animation});

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    Map<String, User> userMap = Provider.of<Map<String, User>>(context);
    if (userMap.isEmpty) return Loading();
    String senderUID = messageSnapshot.data['senderUID'];
    User sender = userMap[senderUID];
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          children: currentUser.uid == senderUID
              ? getSentMessageLayout(sender)
              : getReceivedMessageLayout(sender),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout(User sender) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(
              sender.fullName(),
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(
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
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 0.0),
            child: new CircleAvatar(
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
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.fromLTRB(0.0, 20.0, 5.0, 0.0),
            child: new CircleAvatar(
              backgroundColor: Colors.black87,
              child: Text(
                sender.initials(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              sender.fullName(),
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(
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
