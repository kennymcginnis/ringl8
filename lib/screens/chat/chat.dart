import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringl8/components/animatedList.dart';
import 'package:ringl8/models/message.dart';
import 'package:ringl8/models/user.dart';
import 'package:ringl8/screens/chat/message_list_item.dart';
import 'package:ringl8/services/message.dart';
import 'package:ringl8/services/user.dart';

final analytics = FirebaseAnalytics();
final auth = FirebaseAuth.instance;
var currentUser;
var _scaffoldContext;

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isComposingMessage = false;
  final MessageService _messageService = MessageService();

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<User>(context);
//    return Scaffold(
//        body: Container(
//          child: Column(
//            children: <Widget>[
//              Flexible(
//                child: StreamBuilder<QuerySnapshot>(
//          stream: MessageService().messagesByRecipient(123''),
//            builder: (context, snapshot){
//              return snapshot.hasData ? AnimatedList(
//                  reverse: true,
//                  padding: EdgeInsets.all(8.0),
//                  itemBuilder: (BuildContext context, int index, Animation<double> animation) {
//                    return ChatMessageListItem(
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
//        return ListView(
//          children: snapshot.data.map((document) {
//            return ChatMessageListItem(
//                      messageSnapshot: document,
//                    );
//          }).toList(),
//        );
//      },
//    );
    return StreamProvider<Map<String, User>>.value(
      value: UserService().userMap,
      child: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FirestoreAnimatedList(
                query: _messageService.messagesByRecipient('123'),
                padding: EdgeInsets.all(8.0),
                reverse: true,
                //comparing timestamp of messages to check which one would appear first
                itemBuilder: (
                  _,
                  DocumentSnapshot messageSnapshot,
                  Animation<double> animation,
                  int x,
                ) {
                  return MessageListItem(
                    messageSnapshot: messageSnapshot,
                    animation: animation,
                  );
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
            Builder(builder: (BuildContext context) {
              _scaffoldContext = context;
              return Container(width: 0.0, height: 0.0);
            })
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(
                color: Colors.grey[200],
              )))
            : null,
      ),
    );
  }

  CupertinoButton getIOSSendButton() {
    return CupertinoButton(
      child: Text("Send"),
      onPressed:
          _isComposingMessage ? () => _textMessageSubmitted(_textEditingController.text) : null,
    );
  }

  IconButton getDefaultSendButton() {
    return IconButton(
      icon: Icon(Icons.send),
      onPressed:
          _isComposingMessage ? () => _textMessageSubmitted(_textEditingController.text) : null,
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(
        color:
            _isComposingMessage ? Theme.of(context).accentColor : Theme.of(context).disabledColor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onChanged: (String messageText) {
                  setState(() {
                    _isComposingMessage = messageText.length > 0;
                  });
                },
                onSubmitted: _textMessageSubmitted,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? getIOSSendButton()
                  : getDefaultSendButton(),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) {
    _messageService.sendMessage(Message(
      text: messageText,
      senderUID: currentUser.uid,
      recipientUID: '123',
      timestamp: DateTime.now(),
    ));

    analytics.logEvent(name: 'send_message');
  }
}
