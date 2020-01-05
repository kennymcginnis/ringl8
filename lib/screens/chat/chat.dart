import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ringl8/main.dart';
import 'package:ringl8/routes/app_state.dart';
import 'package:ringl8/screens/chat/animated_list.dart';
import 'package:ringl8/screens/chat/message_list_item.dart';
import 'package:ringl8/services/message.dart';

class ChatScreen extends StatefulWidget {
  final auth = FirebaseAuth.instance;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  var application = sl.get<AppState>();
  bool _isComposingMessage = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(application.currentGroup.name),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: FirestoreAnimatedList(
                  key: ValueKey("list"),
                  query: MessageService().messagesByRecipient,
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  //comparing timestamp of messages to check which one would appear first
                  itemBuilder:
                      (_, DocumentSnapshot messageSnapshot, Animation<double> animation, __) =>
                          MessageListItem(messageSnapshot: messageSnapshot, animation: animation),
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
              Builder(builder: (BuildContext context) => Container(width: 0.0, height: 0.0))
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                )
              : null,
        ),
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
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textEditingController,
                onChanged: (String messageText) {
                  setState(() => _isComposingMessage = messageText.length > 0);
                },
                onSubmitted: _textMessageSubmitted,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Send a message",
                ),
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
    setState(() => _isComposingMessage = false);
    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) {
    MessageService().sendMessage(messageText);
  }
}
