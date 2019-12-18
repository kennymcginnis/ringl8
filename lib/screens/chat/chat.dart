import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/animatedList.dart';
import 'package:ringl8/components/loading.dart';
import 'package:ringl8/models/message.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/services/message.dart';

import 'chatMessageListItem.dart';

final analytics = new FirebaseAnalytics();
final auth = FirebaseAuth.instance;
var currentUser;
var _scaffoldContext;

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController =
  new TextEditingController();
  bool _isComposingMessage = false;
  final MessageService _messageService = MessageService();

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<User>(context);
//    return new Scaffold(
//        body: new Container(
//          child: new Column(
//            children: <Widget>[
//              new Flexible(
//                child: StreamBuilder<QuerySnapshot>(
//          stream: MessageService().messagesByRecipient(123''),
//            builder: (context, snapshot){
//              return snapshot.hasData ? new AnimatedList(
//                  reverse: true,
//                  padding: const EdgeInsets.all(8.0),
//                  itemBuilder: (BuildContext context, int index, Animation<double> animation) {
//                    return new ChatMessageListItem(
//                      animation: animation,
//                      messageSnapshot: snapshot,
//                    );
//                  }
//              );
//        )
//              ]
//          )
//        )
//    )


//    return StreamBuilder<List<Message>>(
//      stream: MessageService().messages,
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return Loading();
//        return new ListView(
//          children: snapshot.data.map((document) {
//            return new ChatMessageListItem(
//                      messageSnapshot: document,
//                    );
//          }).toList(),
//        );
//      },
//    );
    return new Scaffold(
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: new FirestoreAnimatedList(
                  query: _messageService.messagesByRecipient('123'),
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  //comparing timestamp of messages to check which one would appear first
                  itemBuilder: (_, DocumentSnapshot messageSnapshot,
                      Animation<double> animation, int x) {
                    return new ChatMessageListItem(
                      messageSnapshot: messageSnapshot,
                      animation: animation,
                    );
                  },
                ),
              ),
              new Divider(height: 1.0),
              new Container(
                decoration:
                new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
              new Builder(builder: (BuildContext context) {
                _scaffoldContext = context;
                return new Container(width: 0.0, height: 0.0);
              })
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border: new Border(
                  top: new BorderSide(
                    color: Colors.grey[200],
                  )))
              : null,
        ));
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? getIOSSendButton()
                    : getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) {
    _messageService.sendMessage(new Message(
      text: messageText,
      senderUID: currentUser.uid,
      recipientUID: '123',
      timestamp: new DateTime.now(),
    ));

    analytics.logEvent(name: 'send_message');
  }
}